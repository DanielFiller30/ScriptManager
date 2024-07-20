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
    
    var output = ""
    var error = ""
    var finishedCounter = 0
    
    var scripts: [Script] = []
    var savedScripts: [Script] {
        storageHandler.scripts
    }
    
    var runningScript: [Script] = []
    var isRunning: Bool = false
    
    var editScript: Script = EmptyScript
    var editMode: Bool = false
    var selectedIcon: Int = 0
    var input: String = ""
    
    private var process: Process?
    private var settings: Settings {
        storageHandler.settings
    }
    
    init() {
        scripts = storageHandler.scripts
    }
    
    func runScript(_ script: Script, test: Bool) async -> ResultState {
        self.output = ""
        self.error = ""
        
        do {
            process = Process()
            
            let inputPipe = Pipe()
            let outputPipe = Pipe()
            let errorPipe = Pipe()
            
            // Build valid shell command
            let unicode = "export LANG=\(settings.unicode);"
            let profilePath = settings.shell.profile != nil ? "source \(settings.shell.profile!);" : ""
            let validatedCommand = unicode + profilePath + script.command
            
            if let process {
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
                            self.output += line
                        }
                    } else {
                        print("Error decoding data: \(pipe.availableData)")
                    }
                }
                
                // Error handling
                let errorHandle = errorPipe.fileHandleForReading
                let errorData = errorHandle.readDataToEndOfFile()
                error = String(data: errorData, encoding: .utf8) ?? ""
                
                process.waitUntilExit()

                try outHandle.close()
                
                return handleScriptResult(
                    result: process.terminationStatus,
                    test: test,
                    scriptName: script.name
                )
            } else {
                isRunning = false
                return .failed
            }
        } catch {
            print(error)
            isRunning = false
            return .failed
        }
    }
    
    func interruptRunningProcess() {
        if let process {
            process.terminate()
        } else {
            debugPrint("Process not defined")
        }
    }
    
    func saveScripts() {
        storageHandler.scripts = scripts
    }
}

// MARK: - Handle process result
extension ScriptHandler {
    private func handleScriptResult(result: Int32, test: Bool, scriptName: String) -> ResultState {
        debugPrint("State: \(result)")
        if (result == 0) {
            // Script successfull
            if (settings.notifications && !test) {
                NotificationHandler.sendResultNotification(state: true, name: scriptName)
            }
            
            self.finishedCounter += 1
            
            isRunning = false
            return .successfull
        } else if (result == 15) {
            // Script interrupted
            isRunning = false
            return .interrupted
        } else {
            // Script failed
            if (settings.logs && !test) {
                writeLog(pathLogs: settings.pathLogs)
            }
            
            if (settings.notifications && !test) {
                NotificationHandler.sendResultNotification(state: false, name: scriptName)
            }
            
            isRunning = false
            return .failed
        }
    }
    
    private func writeLog(pathLogs: String) {
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
