//
//  ScriptHandler.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 10.02.23.
//

import Foundation

class ScriptHandler: ScriptHandlerProtocol {
    internal var settingsHandler = SettingsHandler()
    
    @Published var output: String = ""
    
    func runScript(_ script: Script, test: Bool) async -> ResultState {
        do {
            let settings = settingsHandler.settings
            let task = Process()
            let pipe = Pipe()
            self.output = ""
            
            // Build valid shell command
            let unicode = "export LANG=\(settings.unicode);"
            let profilePath = settings.shell.profile != nil ? "source \(settings.shell.profile!);" : ""
            let validatedCommand = unicode + profilePath + script.command
            
            task.standardError = pipe
            task.arguments = ["--login","-c", validatedCommand]
            task.executableURL = URL(fileURLWithPath: settings.shell.path)
            task.standardInput = nil
            task.standardOutput = pipe
            
            let outHandle = pipe.fileHandleForReading
            outHandle.readabilityHandler = { pipe in
                if let line = String(data: pipe.availableData, encoding: .utf8) {
                    DispatchQueue.main.async {
                        self.output += line
                    }
                } else {
                    print("Error decoding data: \(pipe.availableData)")
                }
            }
                        
            try task.run()
            task.waitUntilExit()

            try outHandle.close()
            
            return handleScriptResult(
                result: task.terminationStatus,
                test: test,
                scriptName: script.name
            )
            
        } catch {
            print(error)
            return .failed
        }
    }
    
    internal func handleScriptResult(result: Int32, test: Bool, scriptName: String) -> ResultState {
        let settings = settingsHandler.settings
        if (result == 0) {
            if (settings.notifications && !test) {
                NotificationHandler.sendResultNotification(state: true, name: scriptName)
            }
            
            return .successfull
        } else {
            if (settings.logs && !test) {
                writeLog(pathLogs: settings.pathLogs)
            }
            
            if (settings.notifications && !test) {
                NotificationHandler.sendResultNotification(state: false, name: scriptName)
            }
            
            return .failed
        }
    }    
    
    internal func writeLog(pathLogs: String) {
        let url = URL(string: "file://\(pathLogs)")
        guard let validUrl = url else { return }
        
        let fileName = validUrl.appendingPathComponent("log_\(DateHandler.getFormattedDate(date: Date())).txt")
        
        do {
            try output.write(to: fileName, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            print(error)
        }
    }
}
