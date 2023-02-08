//
//  ScriptsListViewModel.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 03.02.23.
//

import Foundation
import AppKit

class ScriptsViewModel: ObservableObject {
    private let storage = StorageHandler()
    
    @Published var scripts: [Script] = []
    @Published var name: String = ""
    @Published var path: String = ""
    //@Published var path: String = "sh /Users/Daniel.Filler/Development/04_Mein_dm/custom_batch_scripts/toolTest.sh"
    
    func loadScripts() {
        self.scripts = storage.loadScripts() ?? []
    }
    
    func runScript(_ command: String) async -> ResultState {
        do {
            var settings = storage.loadSettings()
            if (settings == nil) {
                let homeDirURL = FileManager.default.homeDirectoryForCurrentUser.relativePath
                settings = Settings(shell: Shell(type: .zsh, path: "/bin/zsh", profile: "\(homeDirURL)/.zshrc"), unicode: "en_US.UTF-8")
            }
            
            let task = Process()
            let pipe = Pipe()
            
            let profilePath = settings!.shell.profile != nil ? "source \(settings!.shell.profile!);" : ""
            let validatedCommand = "export LANG=\(settings!.unicode); \(profilePath) \(command)"
            
            task.standardError = pipe
            task.arguments = ["--login","-c", validatedCommand]
            task.executableURL = URL(fileURLWithPath: settings!.shell.path)
            task.standardInput = nil
            task.standardOutput = pipe
            
            try task.run()
            
            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            let output = String(data: data, encoding: .utf8) ?? ""
            
            task.waitUntilExit()
            
            if (task.terminationStatus == 0) {
                return .successfull
            } else {
                writeLog(output: output)
                
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
    
    func writeLog(output: String) {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileName = paths[0].appendingPathComponent("log_\(getFormattedDate(date: Date())).txt")
                
        do {
            try output.write(to: fileName, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            print(error)
        }
    }
    
    func openLogs() {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        NSWorkspace.shared.open(paths[0])
    }
    
    func getFormattedDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.YY HH:mm:ss"        
        
        return dateFormatter.string(from: date)
    }
}
