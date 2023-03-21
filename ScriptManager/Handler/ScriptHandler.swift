//
//  ScriptHandler.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 10.02.23.
//

import Foundation
import UserNotifications

class ScriptHandler: ObservableObject {
    private let storage = StorageHandler()
    var scripts: [Script] = []
    
    func loadScripts() {
        self.scripts = storage.loadScripts() ?? []
    }
    
    func runScript(_ script: Script, test: Bool) async -> ResultState {
        do {
            let settings = storage.loadSettings()
            
            let task = Process()
            let pipe = Pipe()
            
            // Build valid shell command
            let unicode = "export LANG=\(settings.unicode);"
            let profilePath = settings.shell.profile != nil ? "source \(settings.shell.profile!);" : ""
            let validatedCommand = unicode + profilePath + script.command
            
            task.standardError = pipe
            task.arguments = ["--login","-c", validatedCommand]
            task.executableURL = URL(fileURLWithPath: settings.shell.path)
            task.standardInput = nil
            task.standardOutput = pipe
            
            try task.run()
            
            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            let output = String(data: data, encoding: .utf8) ?? ""
            
            task.waitUntilExit()
            
            return handleScriptResult(
                result: task.terminationStatus,
                output: output,
                settings: settings,
                test: test,
                scriptName: script.name
            )
            
        } catch {
            print(error)
            return .failed
        }
    }
    
    private func handleScriptResult(result: Int32, output: String, settings: Settings, test: Bool, scriptName: String) -> ResultState {
        if (result == 0) {
            if (settings.notifications && !test) {
                sendResultNotification(state: true, name: scriptName)
            }
            
            return .successfull
        } else {
            if (settings.logs && !test) {
                writeLog(output: output, pathLogs: settings.pathLogs)
            }
            
            if (settings.notifications && !test) {
                sendResultNotification(state: false, name: scriptName)
            }
            
            return .failed
        }
    }
    
    private func sendResultNotification(state: Bool, name: String) {
        let content = UNMutableNotificationContent()
        content.title = state ? String(localized: "notification-successfull-title \(name)") : String(localized: "notification-failed-title \(name)")
        content.subtitle = state ? String(localized: "notification-successfull-subtitle") : String(localized: "notification-failed-subtitle")
        content.sound = UNNotificationSound.default

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)
        UNUserNotificationCenter.current().add(request)
    }
    
    func sendStartNotification(name: String) {
        let content = UNMutableNotificationContent()
        content.title = String(localized: "notification-start-title \(name)")
        content.subtitle = String(localized: "notification-start-subtitle")
        content.sound = UNNotificationSound.default

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)
        UNUserNotificationCenter.current().add(request)
    }
    
    private func writeLog(output: String, pathLogs: String) {
        let url = URL(string: "file://\(pathLogs)")
        guard let validUrl = url else { return }
        
        let fileName = validUrl.appendingPathComponent("log_\(getFormattedDate(date: Date())).txt")
        
        do {
            try output.write(to: fileName, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            print(error)
        }
    }
    
    func getFormattedDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy HH:mm:ss"
        
        return dateFormatter.string(from: date)
    }
}
