//
//  SettingsHandlerTests.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 30.07.24.
//

@testable import ScriptManager

import Resolver
import Testing
import Foundation

final class SettingsHandlerTests {
    @LazyInjected private var sut: SettingsHandlerProtocol
    @LazyInjected private var storageHandler: StorageHandlerProtocol
    
    @Test("Save settings") func saveSettingsTest() {
        let newSettings = Settings(shell: Shell(type: .zsh, path: ""), unicode: "", logs: false, pathLogs: "", notifications: false, mainColor: ColorConverter.defaultEncodedColor, shortcuts: [])
        
        sut.settings = newSettings
        sut.saveSettings()
        #expect(storageHandler.settings.id == newSettings.id)
    }
}
