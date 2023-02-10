//
//  ScriptsListViewModel.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 03.02.23.
//

import Foundation
import AppKit
import UserNotifications

class ScriptsViewModel: ObservableObject {
    private let storage = StorageHandler()
    
    @Published var scripts: [Script] = []
    @Published var name: String = ""
    @Published var path: String = ""
    
    func loadScripts() {
        self.scripts = storage.loadScripts() ?? []
    }
    
    func loadSettings() -> Settings {
        var settings = storage.loadSettings()
        if (settings == nil) {
            // Load default settings if no saved data
            let homeDirURL = FileManager.default.homeDirectoryForCurrentUser.relativePath
            
            settings = Settings(
                shell: Shell(type: DefaultSettings.shell.type, path: DefaultSettings.shell.path, profile: "\(homeDirURL)/.zshrc"),
                unicode: DefaultSettings.unicode,
                logs: DefaultSettings.logs,
                pathLogs: DefaultSettings.pathLogs,
                notifications: DefaultSettings.notifications
            )
        }
        
        return settings!
    }
    
    func runScript(_ command: String, scriptName: String, test: Bool) async -> ResultState {
        do {
            let settings = loadSettings()
            
            let task = Process()
            let pipe = Pipe()
            
            // Build valid shell command
            let unicode = "export LANG=\(settings.unicode);"
            let profilePath = settings.shell.profile != nil ? "source \(settings.shell.profile!);" : ""
            let validatedCommand = unicode + profilePath + command
            
            task.standardError = pipe
            task.arguments = ["--login","-c", validatedCommand]
            task.executableURL = URL(fileURLWithPath: settings.shell.path)
            task.standardInput = nil
            task.standardOutput = pipe
            
            try task.run()
            
            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            let output = String(data: data, encoding: .utf8) ?? ""
            
            task.waitUntilExit()
            
            if (task.terminationStatus == 0) {
                if (settings.notifications && !test) {
                    sendNotification(state: true, name: scriptName)
                }
                
                return .successfull
            } else {
                if (settings.logs && !test) {
                    writeLog(output: output, pathLogs: settings.pathLogs)
                }
                
                if (settings.notifications && !test) {
                    sendNotification(state: false, name: scriptName)
                }
                
                return .failed
            }
            
        } catch {
            print(error)
            return .failed
        }
    }
    
    func saveScript() {
        var savedScripts: [Script] = storage.loadScripts() ?? []
        savedScripts.append(Script(name: self.name, path: self.path, success: .ready, finished: false ))
        storage.saveScripts(value: savedScripts)
        
        loadScripts()
        self.name = ""
        self.path = ""
    }
    
    func updateScripts() {
        storage.saveScripts(value: self.scripts)
    }
    
    func deleteScript(id: UUID) {
        scripts = scripts.filter {
            $0.id != id
        }
        
        updateScripts()
        
        loadScripts()
    }
    
    func sendNotification(state: Bool, name: String) {
        let content = UNMutableNotificationContent()
        content.title = state ? String(localized: "notification-successfull-title \(name)") : String(localized: "notification-failed-title \(name)")
        content.subtitle = state ? String(localized: "notification-successfull-subtitle") : String(localized: "notification-failed-subtitle")
        content.sound = UNNotificationSound.default

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)
        UNUserNotificationCenter.current().add(request)
    }
    
    func writeLog(output: String, pathLogs: String) {
        let url = URL(string: "file://\(pathLogs)")
        guard let validUrl = url else { return }
        
        let fileName = validUrl.appendingPathComponent("log_\(getFormattedDate(date: Date())).txt")
        
        do {
            try output.write(to: fileName, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            print(error)
        }
    }
    
    func openLogs() {
        let savedSettings: Settings? = storage.loadSettings()
        guard let settings = savedSettings else {return}
        guard let url = URL(string: "file://\(settings.pathLogs)") else {return}
        
        NSWorkspace.shared.open(url)
    }
    
    func getFormattedDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.YY HH:mm:ss"
        
        return dateFormatter.string(from: date)
    }
}
