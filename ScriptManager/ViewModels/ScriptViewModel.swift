//
//  ScriptsListViewModel.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 03.02.23.
//

import Foundation
import AppKit
import SwiftUI

class ScriptViewModel: ObservableObject {
    private let storage = StorageHandler()
    
    @Published var showAddScript: Bool = false
    @Published var scripts: [Script] = []
    @Published var categories: [Category] = []

    @Published var name: String = ""
    @Published var command: String = ""
    @Published var selectedIcon: Int = 0
    @Published var selectedCategory: UUID = UUID()

    @Published var editMode: Bool = false
    @Published var editId: UUID = UUID()
    
    @Published var searchString: String = ""
    
    @Published var isLogEnabled: Bool = DefaultSettings.logs
    
    func loadSettings() {
        let storage = StorageHandler()
        let settings: Settings = storage.loadSettings()
        
        DispatchQueue.main.async {
            self.isLogEnabled = settings.logs
        }
    }
    
    func loadScripts() {
        scripts = storage.loadScripts() ?? []
    }
    
    func filterScripts(category: Category) {
        scripts = scripts.filter({ $0.categoryID == category.id })
    }
    
    func removeCategory(categoryId: UUID?) {
        loadScripts()
        
        guard categoryId != nil else { return }
        
        for (index, script) in scripts.enumerated() {
            if script.categoryID == categoryId {
                scripts[index].categoryID = nil
            }
        }
        
        updateSavedScripts()
    }
    
    func loadCategories() {
        categories = storage.loadCategories() ?? []
        categories.append(EmptyCategory)
    }
    
    func getCategoryById(id: UUID?) -> Category? {
        if id != EmptyCategory.id {
            return categories.first(where: {$0.id == id})
        } else {
            // Empty category
            return nil
        }
    }
    
    func getDecodedColor(data: Data) -> Color {
        do {
            return try decodeColor(from: data)
        } catch {
            return AppColor.Primary
        }
    }
    
    func saveScript() {
        var savedScripts: [Script] = storage.loadScripts() ?? []
        let tempScript = Script(name: name, icon: ScriptIcons[selectedIcon], command: command, success: .ready, finished: false, categoryID: selectedCategory)
        savedScripts.append(tempScript)
        storage.saveScripts(value: savedScripts)
        
        // Refresh data
        loadScripts()
        
        resetForm()
    }
    
    func resetForm() {
        name = ""
        command = ""
        selectedIcon = 0
        selectedCategory = UUID()
    }
    
    func updateSavedScripts() {
        storage.saveScripts(value: scripts)
    }
    
    func deleteScript(id: UUID) {
        scripts = scripts.filter {
            $0.id != id
        }
        
        updateSavedScripts()
        
        loadScripts()
    }
    
    func updateScript() {
        var savedScripts: [Script] = storage.loadScripts() ?? []
        let index: Int? = savedScripts.firstIndex(where: { $0.id == editId })
        
        guard let index else { return }
        savedScripts[index].name = name
        savedScripts[index].icon = ScriptIcons[selectedIcon]
        savedScripts[index].command = command
        savedScripts[index].categoryID = selectedCategory
        
        storage.saveScripts(value: savedScripts)
        
        // Refresh data
        scripts = savedScripts

        closeEdit()
    }
    
    func openEdit(script: Script) {
        editMode = true
        editId = script.id
        
        name = script.name
        command = script.command
        selectedIcon = ScriptIcons.firstIndex(of: script.icon) ?? 0
        selectedCategory = script.categoryID ?? UUID()
        
        showAddScript = true
    }
    
    func closeEdit() {
        editMode = false
        resetForm()
    }
    
    func openLogs() {
        let savedSettings: Settings? = storage.loadSettings()
        guard let settings = savedSettings else {return}
        guard let url = URL(string: "file://\(settings.pathLogs)") else {return}
        
        NSWorkspace.shared.open(url)
    }
}
