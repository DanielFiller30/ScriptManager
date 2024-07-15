//
//  SettingsHandler.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 06.02.23.
//

import Foundation
import UserNotifications
import Resolver
import SwiftUI

@Observable
class SettingsViewModel {
    @LazyInjected @ObservationIgnored private var storageHandler: StorageHandlerProtocol
    @LazyInjected @ObservationIgnored private var tagHandler: TagHandlerProtocol
    @LazyInjected @ObservationIgnored private var alertHandler: AlertHandlerProtocol
    
    var homeDir: String = ""
    @LazyInjected @ObservationIgnored var scriptHandler: ScriptHandlerProtocol
    @LazyInjected @ObservationIgnored var settingsHandler: SettingsHandlerProtocol
    @LazyInjected @ObservationIgnored var modalHandler: ModalHandlerProtocol
    
    var selectedTag: UUID? {
        tagHandler.selectedTag
    }
    
    // Shortcut-Picker
    var selectedScript1: UUID = EmptyScript.id
    var selectedScript2: UUID = EmptyScript.id
    var selectedScript3: UUID = EmptyScript.id
    var selectedScript4: UUID = EmptyScript.id
    var selectedScript5: UUID = EmptyScript.id
    
    func initSettings() {
        // Set initial home path
        homeDir = FileManager.default.homeDirectoryForCurrentUser.relativePath
    }
    
    func getTagColor() -> Color {
        var iconColor = Color.white
        
        do {
            iconColor = try ColorConverter.decodeColor(from: tagHandler.tags.first {$0.id == tagHandler.selectedTag}?.badgeColor ?? EmptyTag.badgeColor)
        } catch {
            // Fallback default color
        }
        
        return iconColor
    }
    
    func showDeleteTagAlert() {        
        alertHandler.showAlert(
            title: String(localized: "delete-tag-title"),
            message: String(localized: "delete-tag-msg"),
            btnTitle: String(localized: "delete"),
            action: {
                self.deleteTag()
                self.alertHandler.hideAlert()
            }
        )
    }
    
    private func deleteTag() {
        // Remove tag from scripts
        scriptHandler.scripts = scriptHandler.savedScripts
                
        for (index, script) in scriptHandler.scripts.enumerated() {
            if script.tagID == selectedTag {
                scriptHandler.scripts[index].tagID = EmptyTag.id
            }
        }
         
        scriptHandler.saveScripts()
        
        // Delete tag
        tagHandler.tags = tagHandler.tags.filter {
            $0.id != selectedTag
        }
                
        tagHandler.saveTags()
        tagHandler.selectedTag = nil
    }
    
    func loadUserDir() -> String {
        // Load user home directory for shell-profile
        let homeDirURL = FileManager.default.homeDirectoryForCurrentUser.relativePath
        return "\(homeDirURL)/.zshrc"
    }
    
    func loadLogsDir() -> String {
        // Load documents folder for logs
        let dirPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return dirPath[0].relativePath
    }
    
    func reset() {
        // Delete all saved data
        storageHandler.resetData()
        
        scriptHandler.scripts = []
        
        tagHandler.selectedTag = nil
        tagHandler.tags = []
    }
    
    func activateNotifications() {
        if (settingsHandler.settings.notifications) {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert], completionHandler: { success, error in
                if success {
                    print("Notifications allowed")
                } else if let error = error {
                    print(error.localizedDescription)
                    self.settingsHandler.settings.notifications = false
                }
            })
        }
    }
    
    @MainActor
    func saveSettings() {
        settingsHandler.saveSettings()
        
        // Hide settings-modal
        modalHandler.hideModal()
    }
    
    @MainActor
    func showCloseAlert() {
        alertHandler.showAlert(
            title: String(localized: "close-app-title"),
            message: String(localized: "close-app-msg"),
            btnTitle: String(localized: "close-app-btn"),
            action: {
                NSApp.terminate(self)
            }
        )
    }
    
    @MainActor
    func showResetAlert() {
        alertHandler.showAlert(
            title: String(localized: "settings-delete-title"),
            message: String(localized: "settings-delete-msg"),
            btnTitle: String(localized: "delete"),
            action: {
                self.reset()
            }
        )
    }
}
