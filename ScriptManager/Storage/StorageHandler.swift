//
//  StorageHandler.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 03.02.23.
//

import Foundation

class StorageHandler: StorageHandlerProtocol {
    @Storage(key: StorageKeys.FIRSTLAUNCH, defaultValue: true)
    var firstLaunch: Bool
    
    @Storage(key: StorageKeys.SCRIPTS, defaultValue: [])
    var scripts: [Script]
    
    @Storage(key: StorageKeys.TAG, defaultValue: [])
    var tags: [Tag]
    
    @Storage(key: StorageKeys.TIMES, defaultValue: [])
    var times: [ScriptTime]
    
    @Storage(key: StorageKeys.SETTINGS, defaultValue: DefaultSettings)
    var settings: Settings
}

// MARK: - Helper functions for StorageHandler
extension StorageHandler {
    // Helper function for immutable self
    /// Set firstLaunch to false
    func setFirstLaunchToFalse() {
        firstLaunch = false
    }
    
    /// Reset all data saved in UserDefaults.
    /// All values will be reset to default
    func resetData() {
        for key in StorageKeys.allCases {
            UserDefaults.standard.removeObject(forKey: key.rawValue)
        }
    }
    
    /// Reset values of key in UserDefaults. (Used for debugging)
    /// Key-values will be reset to default
    func resetValues(_ key: StorageKeys) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
    }
}

enum StorageKeys: String, CaseIterable {
    case FIRSTLAUNCH
    case SCRIPTS
    case SETTINGS
    case TAG
    case TIMES
}
