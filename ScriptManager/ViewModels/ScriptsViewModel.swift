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
    @Published var selectedIcon: Int = 0
    
    func loadScripts() {
        self.scripts = storage.loadScripts() ?? []
    }
    
    func saveScript() {
        var savedScripts: [Script] = storage.loadScripts() ?? []
        savedScripts.append(Script(name: self.name, icon: ScriptIcons[selectedIcon], path: self.path, success: .ready, finished: false ))
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
    
    func openLogs() {
        let savedSettings: Settings? = storage.loadSettings()
        guard let settings = savedSettings else {return}
        guard let url = URL(string: "file://\(settings.pathLogs)") else {return}
        
        NSWorkspace.shared.open(url)
    }
}
