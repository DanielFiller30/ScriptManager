//
//  ScriptHandler.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 10.02.23.
//

import Foundation
import Resolver

@Observable
class ScriptHandler: ScriptHandlerProtocol {
    @LazyInjected @ObservationIgnored private var storageHandler: StorageHandlerProtocol
    
    var finishedCounter = 0
    
    var scripts: [Script] = []
    var savedScripts: [Script] {
        storageHandler.scripts
    }
    
    var runningScript: [Script] = []
    var isRunning = false
    var runningProcesses: [ScriptProcess] = []
    
    var editScript = EmptyScript
    var editMode = false
    var selectedIcon = 0
    var input = ""
    
    private var process: Process?
    private var settings: Settings {
        storageHandler.settings
    }
    
    init() {
        scripts = storageHandler.scripts
    }
    
    func runScript(_ script: Script, test: Bool) async -> Result {
        guard let index = scripts.firstIndex(where: { $0.id == script.id }) else { return Result(state: .failed) }
        
        scripts[index].output = ""
        scripts[index].error = ""
                
        do {
            let process = Process()
            runningProcesses.append(ScriptProcess(scriptId: script.id, process: process))
            
            let inputPipe = Pipe()
            let outputPipe = Pipe()
            let errorPipe = Pipe()
            
            // Build valid shell command
            let unicode = "export LANG=\(settings.unicode);"
            let profilePath = settings.shell.profile != nil ? "source \(settings.shell.profile!);" : ""
            let validatedCommand = unicode + profilePath + script.command
            
            process.arguments = ["--login","-c", validatedCommand]
            process.executableURL = URL(fileURLWithPath: settings.shell.path)
            
            process.standardError = errorPipe
            process.standardInput = inputPipe
            process.standardOutput = outputPipe
            
            try process.run()
            
            // Input handling
            let inputHandle = inputPipe.fileHandleForWriting
            let userInput = script.input ?? ""
            
            inputHandle.write(userInput.data(using: .utf8)!)
            inputHandle.closeFile()
            
            // Output handling
            let outHandle = outputPipe.fileHandleForReading
            outHandle.readabilityHandler = { pipe in
                if let line = String(data: pipe.availableData, encoding: .utf8) {
                    DispatchQueue.main.async {
                        self.scripts[index].output! += line
                    }
                } else {
                    print("Error decoding data: \(pipe.availableData)")
                }
            }
            
            // Error handling
            let errorHandle = errorPipe.fileHandleForReading
            let errorData = errorHandle.readDataToEndOfFile()
            scripts[index].error = String(data: errorData, encoding: .utf8) ?? ""
            
            process.waitUntilExit()
            
            try outHandle.close()
            
            return handleScriptResult(
                result: process.terminationStatus,
                test: test,
                scriptName: script.name,
                output: scripts[index].output ?? "",
                error: scripts[index].error ?? ""
            )
        } catch {
            print(error)
            isRunning = false
            return Result(state: .failed)
        }
    }
    
    func interruptRunningProcess(scriptId: UUID) {
        runningProcesses.forEach { instance in
            if instance.scriptId == scriptId {
                instance.process.terminate()
            }
        }
    }
    
    func saveScripts() {
        storageHandler.scripts = scripts
    }
}

// MARK: - Handle process result
extension ScriptHandler {
    private func handleScriptResult(result: Int32, test: Bool, scriptName: String, output: String, error: String) -> Result {
        if (result == 0) {
            // Script successfull
            if (settings.notifications && !test) {
                NotificationHandler.sendResultNotification(state: true, name: scriptName)
            }
            
            self.finishedCounter += 1
            
            isRunning = false
            return Result(output: output, error: error, state: .successfull)
        } else if (result == 15) {
            // Script interrupted
            isRunning = false
            return Result(output: output, error: error, state: .interrupted)
        } else {
            // Script failed
            if (settings.logs && !test) {
                writeLog(pathLogs: settings.pathLogs, output: output, error: error)
            }
            
            if (settings.notifications && !test) {
                NotificationHandler.sendResultNotification(state: false, name: scriptName)
            }
            
            isRunning = false
            return Result(output: output, error: error, state: .failed)
        }
    }
    
    private func writeLog(pathLogs: String, output: String, error: String) {
        let url = URL(string: "file://\(pathLogs)")
        guard let validUrl = url else { return }
        
        let fileName = validUrl.appendingPathComponent("log_\(Date().toFormattedDate()).txt")
        
        do {
            let log = output + "\n\n" + error
            try log.write(to: fileName, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            print(error)
        }
    }
}
