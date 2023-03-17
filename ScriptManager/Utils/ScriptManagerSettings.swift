//
//  SettingsViewModel.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 06.02.23.
//

import Foundation
import UserNotifications

class ScriptManagerSettings: ObservableObject {
    private let storage = StorageHandler()
    
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

    func loadSettings() {
        let settings = storage.loadSettings()
        homeDir = FileManager.default.homeDirectoryForCurrentUser.relativePath

        // Set saved settings
        self.shell = settings.shell.type
        self.shellPath = settings.shell.path
        self.profilePath = settings.shell.profile ?? loadLogsDir()
        self.unicode = settings.unicode
        self.loggingState = settings.logs
        self.logsPath = settings.pathLogs
        self.notificationState = settings.notifications

        // Load initial directory paths
        self.profilePath = loadUserDir()
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
    
    func save() {
        let settings = Settings(
            shell: Shell(type: shell, path: shellPath, profile: profilePath),
            unicode: unicode,
            logs: loggingState,
            pathLogs: logsPath,
            notifications: notificationState
        )
        
        storage.saveSettings(value: settings)
        
        showingPopover.toggle()
    }
}
