//
//  SettingsHandler.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 06.02.23.
//

import Foundation
import UserNotifications
import SwiftUI
import AnyCodable

class SettingsHandler: SettingsHandlerProtocol {
    internal var storage = StorageHandler()
    
    var settings: Settings = DefaultSettings
    
    @Published var showingPopover: Bool = false
    @Published var showDeleteAlert: Bool = false
    
    @Published var homeDir: String = ""
    
    @Published var shell: ShellType = DefaultSettings.shell.type
    @Published var shellPath: String = DefaultSettings.shell.path
    @Published var profilePath: String = ""
    @Published var unicode: String = DefaultSettings.unicode
    @Published var loggingState: Bool = DefaultSettings.logs
    @Published var logsPath: String = ""
    @Published var notificationState: Bool = DefaultSettings.notifications
    @Published var mainColor: Color = AppColor.Primary
    
    // Shortcut-Picker
    @Published var selectedScript1: UUID = EmptyScript.id
    @Published var selectedScript2: UUID = EmptyScript.id
    @Published var selectedScript3: UUID = EmptyScript.id
    @Published var selectedScript4: UUID = EmptyScript.id
    @Published var selectedScript5: UUID = EmptyScript.id
    
    required init() {
        loadSettings()
        initSettings()
    }
    
    func loadSettings() {
        do {
            settings = try storage.load(Settings.self, key: .SETTINGS)?.get() ?? DefaultSettings
        } catch {
            debugPrint(error)
        }
    }
    
    func initSettings() {
        do {
            // Set initial home path
            homeDir = FileManager.default.homeDirectoryForCurrentUser.relativePath
                        
            // Set saved settings
            self.shell = settings.shell.type
            self.shellPath = settings.shell.path
            self.profilePath = settings.shell.profile ?? loadLogsDir()
            self.profilePath = loadUserDir()
            self.unicode = settings.unicode
            self.loggingState = settings.logs
            self.logsPath = settings.pathLogs
            self.notificationState = settings.notifications
            self.mainColor = try ColorHandler.decodeColor(from: settings.mainColor)
            if !settings.shortcuts.isEmpty {
                for index in 0...settings.shortcuts.count {
                    switch index {
                    case 0:
                        self.selectedScript1 = settings.shortcuts[0].scriptId
                    case 1:
                        self.selectedScript2 = settings.shortcuts[1].scriptId
                    case 2:
                        self.selectedScript3 = settings.shortcuts[2].scriptId
                    case 3:
                        self.selectedScript4 = settings.shortcuts[3].scriptId
                    case 4:
                        self.selectedScript5 = settings.shortcuts[4].scriptId
                    default:
                        return
                    }
                }
            }
        } catch {
            debugPrint("Loading settings failed.")
        }
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
        storage.reset()
    }
    
    func activateNotifications() {
        if (notificationState) {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert], completionHandler: { success, error in
                if success {
                    print("Notifications allowed")
                } else if let error = error {
                    print(error.localizedDescription)
                    self.notificationState = false
                }
            })
        }
    }
    
    func saveSettings() {
        do {
            let encodedColor = try ColorHandler.encodeColor(color: mainColor)
            let shortcuts = [
                Shortcut(shortcutIndex: 0, scriptId: selectedScript1),
                Shortcut(shortcutIndex: 1, scriptId: selectedScript2),
                Shortcut(shortcutIndex: 2, scriptId: selectedScript3),
                Shortcut(shortcutIndex: 3, scriptId: selectedScript4),
                Shortcut(shortcutIndex: 4, scriptId: selectedScript5)
            ]
            
            let settings = Settings(
                shell: Shell(type: shell, path: shellPath, profile: profilePath),
                unicode: unicode,
                logs: loggingState,
                pathLogs: logsPath,
                notifications: notificationState,
                mainColor: encodedColor,
                shortcuts: shortcuts
            )
            
            storage.save(value: AnyCodable(settings), key: .SETTINGS)
            
            // Hide settings-modal
            DispatchQueue.main.async {
                self.showingPopover.toggle()
            }
        } catch {
            debugPrint("Save settings failed: \(error)")
        }
    }
}
