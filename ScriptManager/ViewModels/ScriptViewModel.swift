//
//  ScriptViewModel.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 03.02.23.
//

import Foundation
import AppKit
import SwiftUI
import AnyCodable

class ScriptViewModel: ObservableObject {
    internal let dataHandler = DataHandler.shared
    internal let settingsHandler = SettingsHandler()
    internal let storageHandler = StorageHandler()
    
    @Published var showAddScript: Bool = false

    @Published var editMode: Bool = false
    @Published var editId: UUID = UUID()
    
    // Form values
    @Published var name: String = ""
    @Published var command: String = ""
    @Published var selectedIcon: Int = 0
    @Published var selectedTag: UUID = UUID()
    
    @Published var isLogEnabled: Bool = DefaultSettings.logs
    
    func loadSettings() {
        // Get current settings
        settingsHandler.loadSettings()
        
        // Enable logs button
        DispatchQueue.main.async {
            self.isLogEnabled = self.settingsHandler.settings.logs
        }
    }
    
    func filterScripts(tag: Tag) {
        dataHandler.scripts = dataHandler.scripts.filter({ $0.tagID == tag.id })
    }
    
    func removeTagFromScript(tagId: UUID?) {
        // Refresh scripts to remove filter
        dataHandler.selectedTag = nil
        dataHandler.loadScripts()
        
        guard tagId != nil else { return }
        for (index, script) in dataHandler.scripts.enumerated() {
            if script.tagID == tagId {
                dataHandler.scripts[index].tagID = nil
            }
        }
        
        updateSavedScripts()
    }
    
    func getTagById(id: UUID?) -> Tag? {
        if id != EmptyTag.id {
            return dataHandler.tags.first(where: {$0.id == id})
        } else {
            // Empty tag
            return nil
        }
    }
    
    func saveScript() {
        // Refresh scripts to remove filter
        dataHandler.selectedTag = nil
        dataHandler.loadScripts()
        
        var savedScripts = dataHandler.scripts
        
        let tempScript = Script(name: name, icon: ScriptIcons[selectedIcon], command: command, success: .ready, finished: false, tagID: selectedTag)
        
        savedScripts.append(tempScript)
        storageHandler.save(value: AnyCodable(savedScripts), key: .SCRIPTS)
        
        // Refresh data
        dataHandler.loadScripts()
        
        // Reset form
        resetForm()
    }
    
    func resetForm() {
        name = ""
        command = ""
        selectedIcon = 0
        selectedTag = UUID()
    }
    
    func updateSavedScripts() {
        storageHandler.save(value: AnyCodable(dataHandler.scripts), key: .SCRIPTS)
    }
    
    func deleteScript(id: UUID) {
        // Refresh scripts to remove filter
        dataHandler.loadScripts()
        
        dataHandler.scripts = dataHandler.scripts.filter {
            $0.id != id
        }
        
        updateSavedScripts()
    }
    
    func saveChangedScript() {
        // Refresh scripts to remove filter
        dataHandler.selectedTag = nil
        dataHandler.loadScripts()
        
        let index: Int? = dataHandler.scripts.firstIndex(where: { $0.id == editId })
        
        guard let index else { return }
        var selectedScript = dataHandler.scripts[index]
        selectedScript.name = name
        selectedScript.icon = ScriptIcons[selectedIcon]
        selectedScript.command = command
        selectedScript.tagID = selectedTag
        
        dataHandler.scripts[index] = selectedScript
        
        updateSavedScripts()

        closeEdit()
    }
    
    func openEdit(script: Script) {
        editMode = true
        editId = script.id
        
        name = script.name
        command = script.command
        selectedIcon = ScriptIcons.firstIndex(of: script.icon) ?? 0
        selectedTag = script.tagID ?? UUID()
        
        showAddScript = true
    }
    
    func closeEdit() {
        editMode = false
        resetForm()
    }
    
    func openLogs() {
        let savedSettings: Settings? = settingsHandler.settings
        guard let settings = savedSettings else {return}
        guard let url = URL(string: "file://\(settings.pathLogs)") else {return}
        
        NSWorkspace.shared.open(url)
    }
}
