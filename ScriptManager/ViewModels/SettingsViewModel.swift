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
    @LazyInjected @ObservationIgnored private var alertHandler: AlertHandlerProtocol
    @LazyInjected @ObservationIgnored private var settingsHandler: SettingsHandlerProtocol
    @LazyInjected @ObservationIgnored private var tagHandler: TagHandlerProtocol

    @LazyInjected @ObservationIgnored var scriptHandler: ScriptHandlerProtocol
    @LazyInjected @ObservationIgnored var modalHandler: ModalHandlerProtocol
    
    var homeDir: String = ""
    var settings: Settings {
        settingsHandler.settings
    }
    
    var tempSettings: Settings = DefaultSettings
    var tempProfilePath: String = "" {
        didSet {
            tempSettings.shell.profile = tempProfilePath
        }
    }
    
    var tempShellType: ShellType = .zsh {
        didSet {
            tempSettings.shell.type = tempShellType
            
            let shell: Shell = Shells.filter{ $0.type == tempSettings.shell.type }.first!
            tempSettings.shell.path = shell.path
            tempProfilePath = homeDir + (shell.profile ?? "")
        }
    }
        
    // Shortcut-Picker
    var selectedScript1: UUID = EmptyScript.id
    var selectedScript2: UUID = EmptyScript.id
    var selectedScript3: UUID = EmptyScript.id
    var selectedScript4: UUID = EmptyScript.id
    var selectedScript5: UUID = EmptyScript.id
    
    var selectedKeys1: String = ""
    var selectedKeys2: String = ""
    var selectedKeys3: String = ""
    var selectedKeys4: String = ""
    var selectedKeys5: String = ""
    
    init() {
        self.tempSettings = settings
        self.tempProfilePath = settings.shell.profile ?? ""
        self.tempShellType = settings.shell.type
                
        self.selectedScript1 = settings.shortcuts.count > 0 ? settings.shortcuts[0].scriptId : EmptyScript.id
        self.selectedScript2 = settings.shortcuts.count > 1 ? settings.shortcuts[1].scriptId : EmptyScript.id
        self.selectedScript3 = settings.shortcuts.count > 2 ? settings.shortcuts[2].scriptId : EmptyScript.id
        self.selectedScript4 = settings.shortcuts.count > 3 ? settings.shortcuts[3].scriptId : EmptyScript.id
        self.selectedScript5 = settings.shortcuts.count > 4 ? settings.shortcuts[4].scriptId : EmptyScript.id
    }
    
    func initSettings() {
        // Set initial home path
        homeDir = FileManager.default.homeDirectoryForCurrentUser.relativePath
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
    
    func openLoggingDirectory() {
        let folderChooserPoint = CGPoint(x: 0, y: 0)
        let folderChooserSize = CGSize(width: 500, height: 600)
        let folderChooserRectangle = CGRect(origin: folderChooserPoint, size: folderChooserSize)
        let folderPicker = NSOpenPanel(contentRect: folderChooserRectangle, styleMask: .utilityWindow, backing: .buffered, defer: true)
        
        folderPicker.canChooseDirectories = true
        folderPicker.canChooseFiles = false
        folderPicker.allowsMultipleSelection = false
        folderPicker.canDownloadUbiquitousContents = false
        folderPicker.canResolveUbiquitousConflicts = true
        
        folderPicker.begin { response in
            if response == .OK {
                let pickedFolder = folderPicker.url
                if let pickedFolder {
                    self.tempSettings.pathLogs = pickedFolder.path()
                }
            }
        }
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
        tempSettings.shortcuts = [
            Shortcut(shortcutIndex: 0, scriptId: selectedScript1, keys: selectedKeys1),
            Shortcut(shortcutIndex: 1, scriptId: selectedScript2, keys: selectedKeys2),
            Shortcut(shortcutIndex: 2, scriptId: selectedScript3, keys: selectedKeys3),
            Shortcut(shortcutIndex: 3, scriptId: selectedScript4, keys: selectedKeys4),
            Shortcut(shortcutIndex: 4, scriptId: selectedScript5, keys: selectedKeys5)
        ]
        
        settingsHandler.settings = tempSettings
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
            cancelVisible: true,
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
            cancelVisible: true,
            action: {
                self.reset()
            }
        )
    }
}
