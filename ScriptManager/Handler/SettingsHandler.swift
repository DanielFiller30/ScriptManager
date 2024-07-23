//
//  SettingsHandler.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 15.05.24.
//

import Foundation
import Resolver

@Observable
class SettingsHandler: SettingsHandlerProtocol {
    @LazyInjected @ObservationIgnored private var storageHandler: StorageHandlerProtocol
    
    var settings: Settings = DefaultSettings
    
    init() {
        settings = storageHandler.settings
    }
    
    func saveSettings() {
        storageHandler.settings = settings
    }
}
