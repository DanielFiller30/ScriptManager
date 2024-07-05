//
//  ShortcutViewModel.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 07.06.24.
//

import Foundation
import Resolver

@Observable
class ShortcutViewModel {
    @Injected @ObservationIgnored var modalHandler: ModalHandlerProtocol
    @Injected @ObservationIgnored private var settingsHandler: SettingsHandlerProtocol
    @Injected @ObservationIgnored private var scriptHandler: ScriptHandlerProtocol
    
    var scriptId: UUID = EmptyScript.id
    var keys: String = ""
    
    var shortcuts: [Shortcut] {
        settingsHandler.settings.shortcuts
    }
    
    var scripts: [Script] {
        scriptHandler.scripts
    }
    
    var runningScripts: [Script] {
        scriptHandler.runningScript
    }
    
    func saveShortcut() {
        let newShortcut = Shortcut(shortcutIndex: 0, scriptId: scriptId, keys: keys)
        settingsHandler.settings.shortcuts.append(newShortcut)
        settingsHandler.saveSettings()
        
        modalHandler.hideModal()
    }
        
    func runScript(scriptId: UUID) async {
        guard let script = scripts.first(where: { $0.id == scriptId }) else { return }
        scriptHandler.runningScript.append(script)
        let _ = await scriptHandler.runScript(script, test: false)
        scriptHandler.runningScript = scriptHandler.runningScript.filter({ $0.id != script.id })
    }
}

// MARK: - Helper functions
extension ShortcutViewModel {
    private func getShortcutSpots() {
        
    }
}
