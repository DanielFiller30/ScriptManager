//
//  SettingsHandlerProtocol.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 15.05.24.
//

import Foundation

protocol SettingsHandlerProtocol {
    var settings: Settings { get set }
    
    func saveSettings()
}
