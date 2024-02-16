//
//  StorageHandlerProtocol.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 05.04.23.
//

import Foundation
import AnyCodable

protocol StorageHandlerProtocol: ObservableObject {
    func save(value: AnyCodable, key: StorageKey)
    func load<T: Decodable>(_ dynamicType: T.Type, key: StorageKey) -> Result<T,Error>?
    func reset()
    func resetByKey(_ key: StorageKey)
}
