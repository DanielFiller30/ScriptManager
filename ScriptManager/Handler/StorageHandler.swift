//
//  StorageHandler.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 03.02.23.
//

import Foundation

class StorageHandler: ObservableObject {
    public func loadFirstLaunch() -> Bool {
        return UserDefaults.standard.bool(forKey: StorageKey.FIRSTLAUNCH.rawValue)
    }
    
    public func updateFirstLaunch() {
        UserDefaults.standard.set(true, forKey: StorageKey.FIRSTLAUNCH.rawValue)
    }
    
    public func saveScripts(value: [Script]) {
        if let encoded = try? JSONEncoder().encode(value) {
            UserDefaults.standard.set(encoded, forKey: StorageKey.SCRIPTS.rawValue)
        }
    }
    
    public func loadScripts() -> [Script]? {
        if let data = UserDefaults.standard.data(forKey: StorageKey.SCRIPTS.rawValue) {
            if let decoded = try? JSONDecoder().decode([Script].self, from: data) {
                return decoded
            }
        }
        
        return nil
    }
    
    public func saveSettings(value: Settings) {
        if let encoded = try? JSONEncoder().encode(value) {
            UserDefaults.standard.set(encoded, forKey: StorageKey.SETTINGS.rawValue)
        }
    }
    
    public func loadSettings() -> Settings {
        if let data = UserDefaults.standard.data(forKey: StorageKey.SETTINGS.rawValue) {
            if let decoded = try? JSONDecoder().decode(Settings.self, from: data) {
                return decoded
            } else {
                return getDefaultSettings()
            }
        } else {
            return getDefaultSettings()
        }
    }
    
    private func getDefaultSettings() -> Settings {
        // Load default settings if no saved data
        let homeDirURL = FileManager.default.homeDirectoryForCurrentUser.relativePath
        
        let settings = Settings(
            shell: Shell(type: DefaultSettings.shell.type, path: DefaultSettings.shell.path, profile: "\(homeDirURL)/.zshrc"),
            unicode: DefaultSettings.unicode,
            logs: DefaultSettings.logs,
            pathLogs: DefaultSettings.pathLogs,
            notifications: DefaultSettings.notifications,
            mainColor: DefaultSettings.mainColor!,
            shortcuts: DefaultSettings.shortcuts
        )
        
        return settings
    }
    
    public func saveCategory(value: [Category]) {
        if let encoded = try? JSONEncoder().encode(value) {
            UserDefaults.standard.set(encoded, forKey: StorageKey.CATEGORY.rawValue)
        }
    }
    
    public func loadCategories() -> [Category]? {
        if let data = UserDefaults.standard.data(forKey: StorageKey.CATEGORY.rawValue) {
            if let decoded = try? JSONDecoder().decode([Category].self, from: data) {
                return decoded
            }
        }
        
        return nil
    }
    
    public func reset() {
        UserDefaults.standard.reset()
    }
    
    public func removeCategories() {
        UserDefaults.standard.removeObject(forKey: StorageKey.CATEGORY.rawValue)
    }
}

extension UserDefaults {
    func reset() {
        StorageKey.allCases.forEach { removeObject(forKey: $0.rawValue) }
    }
}

enum StorageKey: String, CaseIterable {
    case SCRIPTS
    case SETTINGS
    case FIRSTLAUNCH
    case CATEGORY
}
