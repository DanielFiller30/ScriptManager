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
    internal let scriptHandler = ScriptHandler()
    
    @Published var showAddScript: Bool = false
    
    @Published var editMode: Bool = false
    @Published var editId: UUID = UUID()
    
    // Form values
    @Published var name: String = ""
    @Published var command: String = ""
    @Published var selectedIcon: Int = 0
    @Published var selectedTag: UUID = UUID()
    
    @Published var isLogEnabled: Bool = DefaultSettings.logs
    @Published var runningScript: [Script] = []
    @Published var sciptTimes: [ScriptTime] = []
    @Published var isRunning: Bool = false
    
    private var runningTimer: Timer?
    
    @MainActor
    func runScript(showOutput: Bool, scriptId: UUID) {
        Task {
            guard var tempScripts = try storageHandler.load([Script].self, key: .SCRIPTS)?.get() else { return }
            guard let index = tempScripts.firstIndex(where: { $0.id == scriptId }) else { return }
            
            changeIsRunningState(state: true)
            
            if showOutput {
                openOutputWindow()
            }
            
            var tempTimes = self.sciptTimes
            var tempIndex = 0
            if let timeIndex = tempTimes.firstIndex(where: { $0.scriptId == scriptId }) {
                tempIndex = timeIndex
            } else {
                tempTimes.append(ScriptTime(scriptId: scriptId))
                tempIndex = tempTimes.count - 1
            }
            
            let runningIndex = tempIndex
            let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                tempTimes[runningIndex].currentTime += 1
            }
            
            startRunningTimer(tempTimes[runningIndex].runningTimes, runningIndex)
            
            // Update all scripts
            let success = await scriptHandler.runScript(tempScripts[index], test: false)
            
            timer.invalidate()
            runningTimer?.invalidate()
            
            let finishedTime = tempTimes[runningIndex].currentTime
            
            if success == .successfull {
                tempTimes[runningIndex].runningTimes.append(finishedTime)
            }
            
            tempTimes[runningIndex].currentTime = 0
            tempTimes[runningIndex].remainingTime = nil
            tempTimes[runningIndex].progressValue = 1.0

            storageHandler.save(value: AnyCodable(tempTimes), key: .TIMES)
            
            tempScripts[index].success = success
            tempScripts[index].finished = true
            tempScripts[index].lastRun = Date.now
            storageHandler.save(value: AnyCodable(tempScripts), key: .SCRIPTS)
            
            // Update local scripts (filtered)
            let scriptIndex = self.dataHandler.scripts.firstIndex(where: { $0.id == scriptId })
            guard let index = scriptIndex else { return }
            self.dataHandler.scripts[index].success = success
            self.dataHandler.scripts[index].finished = true
            self.dataHandler.scripts[index].lastRun = Date.now
            self.sciptTimes = tempTimes
            
            changeIsRunningState(state: false)
            
            self.runningScript = self.runningScript.filter { $0.id != scriptId }
            
            // Check if logs enabled
            loadSettings()
        }
    }
    
    private func startRunningTimer(_ previousTimes: [Int],_ runningIndex: Int) {
        if previousTimes.count > 3 {
            var totalTime = previousTimes.reduce(0, +) / previousTimes.count
            let tempTotalTime = totalTime
            
            runningTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                if totalTime >= 1 {
                    totalTime -= 1
                    
                    let mins = String(format: "%02d", totalTime / 60)
                    let secs = String(format: "%02d", totalTime % 60)
                    let progress = Double(totalTime) / Double(tempTotalTime)
                    
                    DispatchQueue.main.async {
                        withAnimation {
                            self.sciptTimes[runningIndex].remainingTime = "\(mins):\(secs)"
                            self.sciptTimes[runningIndex].progressValue = progress
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        withAnimation {
                            self.sciptTimes[runningIndex].remainingTime = nil
                            self.sciptTimes[runningIndex].progressValue = 0.0
                        }
                    }
                }
            }
        }
    }
    
    @MainActor
    func changeIsRunningState(state: Bool) {
        if !state {
            if self.runningScript.isEmpty {
                self.isRunning = false
            }
        } else {
            self.isRunning = true
        }
    }
    
    private func openOutputWindow() {
        DispatchQueue.main.async {
            let window = NSWindow()
            let contentView = OutputWindowView(scriptHandler: self.scriptHandler)
            window.contentViewController = NSHostingController(rootView: contentView)
            window.styleMask = [.titled, .resizable, .closable, .miniaturizable]
            window.center()
            window.title = "Output"
            window.isReleasedWhenClosed = false
            window.orderFrontRegardless()
            window.makeKeyAndOrderFront(nil)
        }
    }
    
    @MainActor
    func loadSettings() {
        // Get current settings
        settingsHandler.loadSettings()
        
        // Enable logs button
        self.isLogEnabled = self.settingsHandler.settings.logs
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
        
        dataHandler.selectedTag = tagId
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
        
        // Refresh data
        dataHandler.loadScripts()
        
        closeEdit()
    }
    
    @MainActor
    func openEdit(script: Script) {
        editMode = true
        editId = script.id
        
        name = script.name
        command = script.command
        selectedIcon = ScriptIcons.firstIndex(of: script.icon) ?? 0
        selectedTag = script.tagID ?? UUID()
        
        self.showAddScript = true
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
    
    @MainActor
    func loadScriptTimes() {
        do {
            self.sciptTimes = try self.storageHandler.load([ScriptTime].self, key: .TIMES)?.get() ?? []
        } catch {
            debugPrint("Error while loading script times")
        }
    }
}
