//
//  ScriptViewModel.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 03.02.23.
//

import Foundation
import Resolver
import SwiftUI
import KeyboardShortcuts

@Observable
class ScriptViewModel {
    @LazyInjected @ObservationIgnored var storageHandler: StorageHandlerProtocol
    @LazyInjected @ObservationIgnored var modalHandler: ModalHandlerProtocol
    @LazyInjected @ObservationIgnored var scriptHandler: ScriptHandlerProtocol
    @LazyInjected @ObservationIgnored var tagHandler: TagHandlerProtocol
    
    @LazyInjected @ObservationIgnored private var settingsHandler: SettingsHandlerProtocol
    @LazyInjected @ObservationIgnored private var alertHandler: AlertHandlerProtocol
    @LazyInjected @ObservationIgnored private var hintHandler: HintHandlerProtocol
    
    private var runningTimer: Timer?
    
    var scripts: [Script] {
        scriptHandler.scripts
    }
    
    var editMode: Bool {
        scriptHandler.editMode
    }
    
    var isLogEnabled: Bool {
        settingsHandler.settings.logs
    }
    
    var searchString: String = ""
    
    @MainActor
    func runScript(showOutput: Bool, scriptId: UUID) {
        Task {
            var tempScript = scriptHandler.scripts.first { $0.id == scriptId }
            if tempScript == nil { return }
            
            var finishedTime = 0
            tempScript!.output = ""
            tempScript!.error = ""
            
            if showOutput {
                openOutputWindow(script: tempScript!)
            }
            
            // Track new running time
            if tempScript!.time == nil {
                tempScript!.time = DefaultScriptTime
            }
            
            let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                DispatchQueue.main.async {
                    finishedTime += 1
                }
            }
            
            // Start timer for countdown
            startRunningTimer(tempScript!)
            
            // Update all scripts
            let result = await scriptHandler.runScript(tempScript!, test: false)
            
            // Stop track timer for new last time
            timer.invalidate()
            // Stop countdown timer for displaying
            runningTimer?.invalidate()
            
            // If successfull, save new last run time
            if result.state == .successfull {
                tempScript!.time!.lastTime = finishedTime
                // Reset time values for script
                tempScript!.time!.currentTime = 0
                tempScript!.time!.remainingTime = nil
                tempScript!.time!.progressValue = 1.0
            }
            
            // Save script result
            tempScript!.success = result.state
            tempScript!.finished = true
            tempScript!.lastRun = Date.now
            tempScript!.output = result.output
            tempScript!.error = result.error
            
            let saveIndex = scriptHandler.scripts.firstIndex(where: { $0.id == scriptId })!
            scriptHandler.scripts[saveIndex] = tempScript!
            
            let storageIndex = storageHandler.scripts.firstIndex(where: { $0.id == scriptId })!
            storageHandler.scripts[storageIndex] = tempScript!
            
            scriptHandler.runningScript = scriptHandler.runningScript.filter { $0.id != scriptId }
        }
    }
    
    @MainActor
    func searchForScript() {
        tagHandler.selectedTag = nil
        
        if searchString.isEmpty {
            scriptHandler.scripts = scriptHandler.savedScripts
        } else {
            scriptHandler.scripts = scriptHandler.savedScripts.filter { $0.name.lowercased().contains(searchString.lowercased()) }
        }
    }        
    
    @MainActor
    func removeTagFromScript(tagId: UUID?) {
        guard tagId != nil else { return }
        
        resetScripts()
        
        for (index, script) in scriptHandler.scripts.enumerated() {
            if script.tagID == tagId {
                scriptHandler.scripts[index].tagID = EmptyTag.id
            }
        }
        
        scriptHandler.saveScripts()
        tagHandler.selectedTag = tagId
    }
    
    func getTagById(id: UUID) -> Tag? {
        if id != EmptyTag.id {
            return tagHandler.tags.first(where: {$0.id == id})
        } else {
            // Empty tag
            return nil
        }
    }
    
    func getMatchingShortcut(_ id: UUID) -> Shortcut? {
        return settingsHandler.settings.shortcuts.first(where: { $0.scriptId == id })
    }
    
    @MainActor
    func saveScript() {
        resetScripts()
        
        var updatedScripts = scriptHandler.savedScripts
        
        // Change uuid for new script
        scriptHandler.editScript.id = UUID()
        scriptHandler.editScript.input = scriptHandler.input
        scriptHandler.editScript.icon = ScriptIcons[scriptHandler.selectedIcon]
        updatedScripts.append(scriptHandler.editScript)
        
        scriptHandler.scripts = updatedScripts
        scriptHandler.saveScripts()
        
        resetForm()
        
        modalHandler.hideModal()
        hintHandler.showHint(String(localized: "save-script-success"), type: .success)
    }
    
    @MainActor
    func showDeleteScriptAlert(id: UUID) {
        alertHandler.showAlert(
            title: String(localized: "delete-title"),
            message: String(localized: "delete-msg"),
            btnTitle: String(localized: "delete"),
            cancelVisible: true,
            action: {
                self.deleteScript(id: id)
                self.alertHandler.hideAlert()
                self.hintHandler.showHint(String(localized: "script-deleted"), type: .success)
            }
        )
    }
    
    @MainActor
    func saveChangedScript() {
        resetScripts()
        scriptHandler.scripts = scriptHandler.savedScripts
        
        let editScript = scriptHandler.editScript
        let index: Int? = scriptHandler.scripts.firstIndex(where: { $0.id == editScript.id })
        
        guard let index else { return }
        var selectedScript = scriptHandler.scripts[index]
        selectedScript.name = editScript.name
        selectedScript.icon = ScriptIcons[scriptHandler.selectedIcon]
        selectedScript.command = editScript.command
        selectedScript.tagID = editScript.tagID
        selectedScript.input = scriptHandler.input
        
        scriptHandler.scripts[index] = selectedScript
        scriptHandler.saveScripts()
        
        scriptHandler.editMode = false
        resetForm()
        
        modalHandler.hideModal()
        hintHandler.showHint(String(localized: "save-edit-script-success"), type: .success)
    }
    
    @MainActor
    func openEdit(script: Script) {
        scriptHandler.editMode = true
        scriptHandler.editScript = script
        
        let icon = ScriptIcons.firstIndex(where: {$0 == script.icon}) ?? 0
        scriptHandler.selectedIcon = icon
        scriptHandler.input = script.input ?? ""
        
        modalHandler.showModal(.EDIT_SCRIPT)
    }
    
    func openLogs() {
        let settings = settingsHandler.settings
        guard let url = URL(string: "file://\(settings.pathLogs)") else {return}
        
        NSWorkspace.shared.open(url)
    }
    
    func getTagColor(_ tagId: UUID?) -> Color {
        var iconColor = Color.white
        if let tagId {
            do {
                iconColor = try ColorConverter.decodeColor(from: self.getTagById(id: tagId)?.badgeColor ?? EmptyTag.badgeColor)
            } catch {
                // Fallback default color
            }
        }
        
        return iconColor
    }
    
    @MainActor
    func openOutputWindow(script: Script) {
        let window = NSWindow()
        let contentView = OutputWindowView(script: script, window: window)
        window.contentViewController = NSHostingController(rootView: contentView)
        window.styleMask = [.titled, .resizable, .closable, .miniaturizable]
        window.center()
        window.title = "Output"
        window.isReleasedWhenClosed = false
        window.orderFrontRegardless()
        window.makeKeyAndOrderFront(nil)
    }
}

// MARK: - Helper functions
extension ScriptViewModel {
    @MainActor
    private func deleteScript(id: UUID) {
        scriptHandler.scripts = scriptHandler.scripts.filter {
            $0.id != id
        }
        
        scriptHandler.saveScripts()
        
        deleteShortcut(id)
    }
    
    @MainActor
    private func deleteShortcut(_ id: UUID) {
        // Remove shortcut from keyboardshortcuts-register
        settingsHandler.settings.shortcuts.forEach { shortcut in
            if shortcut.scriptId == id {
                let shortcutName = getShortcutName(index: shortcut.shortcutIndex)
                guard let shortcutName else { return }
                KeyboardShortcuts.reset(shortcutName)
            }
        }
        
        // Remove shortcut from settings
        settingsHandler.settings.shortcuts = settingsHandler.settings.shortcuts.filter { $0.scriptId != id }
        settingsHandler.saveSettings()
    }
    
    @MainActor
    private func getShortcutName(index: Int) -> KeyboardShortcuts.Name? {
        switch index {
        case 0:
            return .runScript1
        case 1:
            return .runScript2
        case 2:
            return .runScript3
        case 3:
            return .runScript4
        case 4:
            return .runScript5
        default:
            return nil
        }
    }
    
    @MainActor
    func hideModal() {
        scriptHandler.editMode = false
        resetForm()
        modalHandler.hideModal()
    }
    
    @MainActor
    private func resetForm() {
        scriptHandler.selectedIcon = 0
        scriptHandler.editScript = EmptyScript
    }
    
    @MainActor
    private func resetScripts() {
        tagHandler.selectedTag = nil
    }
}

// MARK: - Process timer handling
extension ScriptViewModel {
    private func startRunningTimer(_ script: Script) {
        guard script.time!.lastTime != nil else { return }
        
        var totalTime = script.time!.lastTime!
        let tempTotalTime = totalTime
        
        self.runningTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if totalTime >= 1 {
                totalTime -= 1
                
                let mins = String(format: "%02d", totalTime / 60)
                let secs = String(format: "%02d", totalTime % 60)
                let progress = Double(totalTime) / Double(tempTotalTime)
                
                DispatchQueue.main.async {
                    self.updateTime(scriptId: script.id, remainingTime: "\(mins):\(secs)", progressVal: progress)
                }
            } else {
                DispatchQueue.main.async {
                    self.updateTime(scriptId: script.id, remainingTime: nil, progressVal: 0.0)
                }
            }
        }
    }
    
    @MainActor
    private func updateTime(scriptId: UUID, remainingTime: String?, progressVal: Double) {
        withAnimation {
            guard let index = scriptHandler.scripts.firstIndex(where: { $0.id == scriptId }) else { return }
            scriptHandler.scripts[index].time!.remainingTime = remainingTime
            scriptHandler.scripts[index].time!.progressValue = progressVal
        }
    }
}
