//
//  ScriptViewModel.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 03.02.23.
//

import Foundation
import Resolver
import SwiftUI

@Observable
class ScriptViewModel {
    @LazyInjected @ObservationIgnored private var alertHandler: AlertHandlerProtocol
    @LazyInjected @ObservationIgnored var modalHandler: ModalHandlerProtocol
    @LazyInjected @ObservationIgnored var scriptHandler: ScriptHandlerProtocol
    @LazyInjected @ObservationIgnored private var tagHandler: TagHandlerProtocol
    @LazyInjected @ObservationIgnored private var settingsHandler: SettingsHandlerProtocol

    private var runningTimer: Timer?
    
    var scripts: [Script] {
        scriptHandler.scripts
    }
    
    var editMode: Bool {
        scriptHandler.editMode
    }
    
    var isLogEnabled: Bool = DefaultSettings.logs
    var runningScript: [Script] = []
    var sciptTimes: [ScriptTime] = []
    var isRunning: Bool = false
        
    @MainActor
    func runScript(showOutput: Bool, scriptId: UUID) {
        Task {
            var tempScripts = scriptHandler.scripts
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
                DispatchQueue.main.async {
                    tempTimes[runningIndex].currentTime += 1
                }
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
            
            // Save process time
            tempTimes[runningIndex].currentTime = 0
            tempTimes[runningIndex].remainingTime = nil
            tempTimes[runningIndex].progressValue = 1.0
            scriptHandler.times = tempTimes
            
            // Save script result
            tempScripts[index].success = success
            tempScripts[index].finished = true
            tempScripts[index].lastRun = Date.now
            scriptHandler.scripts = tempScripts
            scriptHandler.saveScripts()
                        
            changeIsRunningState(state: false)
            
            self.runningScript = self.runningScript.filter { $0.id != scriptId }
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
    
    @MainActor
    func saveScript() {
        resetScripts()
        
        var updatedScripts = scriptHandler.scripts
        
        // Change uuid for new script
        scriptHandler.editScript.id = UUID()
        scriptHandler.editScript.icon = ScriptIcons[scriptHandler.selectedIcon]
        updatedScripts.append(scriptHandler.editScript)
        
        scriptHandler.scripts = updatedScripts
        scriptHandler.saveScripts()
                
        resetForm()
    }
    
    @MainActor
    func showDeleteScriptAlert(id: UUID) {
        alertHandler.showAlert(
            title: String(localized: "delete-title"),
            message: String(localized: "delete-msg"),
            btnTitle: String(localized: "delete"),
            action: {
                self.deleteScript(id: id)
                self.alertHandler.hideAlert()
            }
        )
    }
    
    @MainActor
    func saveChangedScript() {
        resetScripts()
                
        let editScript = scriptHandler.editScript
        let index: Int? = scriptHandler.scripts.firstIndex(where: { $0.id == editScript.id })
        
        guard let index else { return }
        var selectedScript = scriptHandler.scripts[index]
        selectedScript.name = editScript.name
        selectedScript.icon = ScriptIcons[scriptHandler.selectedIcon]
        selectedScript.command = editScript.command
        selectedScript.tagID = editScript.tagID
        
        scriptHandler.scripts[index] = selectedScript
        scriptHandler.saveScripts()
        
        scriptHandler.editMode = false
        resetForm()
    }
    
    @MainActor
    func openEdit(script: Script) {
        scriptHandler.editMode = true
        scriptHandler.editScript = script
        
        modalHandler.showEditScriptModal()
    }

    func openLogs() {
        let settings = settingsHandler.settings
        guard let url = URL(string: "file://\(settings.pathLogs)") else {return}
        
        NSWorkspace.shared.open(url)
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
    }
    
    @MainActor
    private func changeIsRunningState(state: Bool) {
        if !state {
            if runningScript.isEmpty {
                isRunning = false
            }
        } else {
            isRunning = true
        }
    }
    
    @MainActor
    private func openOutputWindow() {
        let window = NSWindow()
        let contentView = OutputWindowView()
        window.contentViewController = NSHostingController(rootView: contentView)
        window.styleMask = [.titled, .resizable, .closable, .miniaturizable]
        window.center()
        window.title = "Output"
        window.isReleasedWhenClosed = false
        window.orderFrontRegardless()
        window.makeKeyAndOrderFront(nil)
    }
    
    @MainActor
    private func resetForm() {
        scriptHandler.editScript.name = ""
    }
    
    @MainActor
    private func resetScripts() {
        tagHandler.selectedTag = nil
    }
}

// MARK: - Process timer handling
extension ScriptViewModel {
    private func startRunningTimer(_ previousTimes: [Int],_ runningIndex: Int) {
        if previousTimes.count > 3 {
            var totalTime = previousTimes.reduce(0, +) / previousTimes.count
            let tempTotalTime = totalTime
            
            self.runningTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                if totalTime >= 1 {
                    totalTime -= 1
                    
                    let mins = String(format: "%02d", totalTime / 60)
                    let secs = String(format: "%02d", totalTime % 60)
                    let progress = Double(totalTime) / Double(tempTotalTime)
                    
                    DispatchQueue.main.async {
                        self.updateTime(index: runningIndex, remainingTime: "\(mins):\(secs)", progressVal: progress)
                    }
                } else {
                    DispatchQueue.main.async {
                        self.updateTime(index: runningIndex, remainingTime: nil, progressVal: 0.0)
                    }
                }
            }
        }
    }
    
    @MainActor
    private func updateTime(index: Int, remainingTime: String?, progressVal: Double) {
        withAnimation {
            sciptTimes[index].remainingTime = remainingTime
            sciptTimes[index].progressValue = progressVal
        }
    }
}
