//
//  ScriptsListViewModel.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 03.02.23.
//

import Foundation

class ScriptsViewModel: ObservableObject {
    private let storage = StorageHandler()
    
    @Published var scripts: [Script] = []

    var name: String = ""
    var path: String = "sh /Users/Daniel.Filler/Development/04_Mein_dm/custom_batch_scripts/toolTest.sh"
    
    func loadScripts() {
        self.scripts = storage.loadScripts() ?? []
        print(String(scripts.count))
    }
    
    func runScript(_ command: String) async -> ResultState {
        do {
            let task = Process()
            let pipe = Pipe()
            
            task.standardError = pipe
            task.arguments = ["-c", command]
            task.executableURL = URL(fileURLWithPath: "/bin/zsh")
            task.standardInput = nil
            
            try task.run()
            task.waitUntilExit()
            
            print("Finished")
            
            if (task.terminationStatus == 0) {
                return .successfull
            } else {
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
    }
    
    func updateScripts() {        
        storage.saveScripts(value: self.scripts)
    }
    
    func getFormattedDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.YY HH:mm:ss"
        return dateFormatter.string(from: date)
    }
}
