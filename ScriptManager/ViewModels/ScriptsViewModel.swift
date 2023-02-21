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
    
    @Published var showAddScript: Bool = false
    @Published var scripts: [Script] = []
    
    @Published var name: String = ""
    @Published var command: String = ""
    @Published var selectedIcon: Int = 0
    
    @Published var editMode: Bool = false
    @Published var editId: UUID = UUID()
    
    @Published var isLogEnabled: Bool = DefaultSettings.logs
    
    func loadSettings() {
        let storage = StorageHandler()
        let settings: Settings = storage.loadSettings()
        
        self.isLogEnabled = settings.logs
    }
    
    func loadScripts() {
        self.scripts = storage.loadScripts() ?? []
    }
    
    func saveScript() {
        var savedScripts: [Script] = storage.loadScripts() ?? []
        savedScripts.append(Script(name: self.name, icon: ScriptIcons[selectedIcon], command: self.command, success: .ready, finished: false ))
        storage.saveScripts(value: savedScripts)
        
        // Refresh data
        loadScripts()
        
        resetForm()
    }
    
    func resetForm() {
        self.name = ""
        self.command = ""
        self.selectedIcon = 0
    }
    
    func refreshScripts() {
        storage.saveScripts(value: self.scripts)
    }
    
    func deleteScript(id: UUID) {
        scripts = scripts.filter {
            $0.id != id
        }
        
        refreshScripts()
        
        loadScripts()
    }
    
    func updateScript() {
        var savedScripts: [Script] = storage.loadScripts() ?? []
        let index: Int? = savedScripts.firstIndex(where: { $0.id == self.editId })
        
        guard let index else { return }
        savedScripts[index].name = self.name
        savedScripts[index].icon = ScriptIcons[self.selectedIcon]
        savedScripts[index].command = self.command
        
        storage.saveScripts(value: savedScripts)
        
        // Refresh data
        self.scripts = savedScripts

        closeEdit()
    }
    
    func openEdit(script: Script) {
        self.editMode = true
        self.editId = script.id
        
        self.name = script.name
        self.command = script.command
        self.selectedIcon = ScriptIcons.firstIndex(of: script.icon) ?? 0
        
        self.showAddScript = true
    }
    
    func closeEdit() {
        self.editMode = false
        self.resetForm()
        
        self.showAddScript.toggle()
    }
    
    func openLogs() {
        let savedSettings: Settings? = storage.loadSettings()
        guard let settings = savedSettings else {return}
        guard let url = URL(string: "file://\(settings.pathLogs)") else {return}
        
        NSWorkspace.shared.open(url)
    }
}
