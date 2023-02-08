//
//  StorageHandler.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 03.02.23.
//

import Foundation

class StorageHandler: ObservableObject {
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
    
    public func loadSettings() -> Settings? {
        if let data = UserDefaults.standard.data(forKey: StorageKey.SETTINGS.rawValue) {
            if let decoded = try? JSONDecoder().decode(Settings.self, from: data) {
                return decoded
            }
        }
        
        return nil
    }
    
    public func reset() {
        UserDefaults.standard.reset()
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
}
