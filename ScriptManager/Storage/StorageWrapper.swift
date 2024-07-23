//
//  StorageWrapper.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 28.03.24.
//

import Foundation

@propertyWrapper
struct Storage<T: Codable> {
    private let key: StorageKeys
    private let defaultValue: T
    
    init(key: StorageKeys, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: T {
        get {
            // Read value from UserDefaults
            guard let data = UserDefaults.standard.object(forKey: key.rawValue) as? Data else {
                // Return defaultValue when no data in UserDefaults
                return defaultValue
            }
            
            // Convert data to the desire data type
            let value = try? JSONDecoder().decode(T.self, from: data)
            return value ?? defaultValue
        }
        set {
            // Convert newValue to data
            let data = try? JSONEncoder().encode(newValue)
            
            // Set value to UserDefaults
            UserDefaults.standard.set(data, forKey: key.rawValue)
        }
    }
}

