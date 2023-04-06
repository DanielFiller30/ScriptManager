//
//  StorageHandler.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 03.02.23.
//

import Foundation
import AnyCodable

class StorageHandler: StorageHandlerProtocol {
    public func save(value: AnyCodable, key: StorageKey) {
        if let encoded = try? JSONEncoder().encode(value) {
            UserDefaults.standard.set(encoded, forKey: key.rawValue)
        }
    }
    
    public func load<T: Decodable>(_ dynamicType: T.Type, key: StorageKey) -> Result<T,Error>? {
        if let data = UserDefaults.standard.data(forKey: key.rawValue) {
            return Result { try JSONDecoder().decode(dynamicType.self, from: data) }
        } else {
            return nil
        }
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
    case FIRSTLAUNCH
    case SCRIPTS
    case SETTINGS
    case TAG
}
