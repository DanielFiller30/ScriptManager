//
//  ModalHandler.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 06.06.24.
//

import Foundation
import SwiftUI

@Observable
class ModalHandler: ModalHandlerProtocol {
    var modalVisible: Bool = false
    var type: ModalType = .ADD_SCRIPT
     
    @MainActor
    func showAddScriptModal() {
        type = .ADD_SCRIPT
        showModal()
    }
    
    @MainActor
    func showEditScriptModal() {
        type = .EDIT_SCRIPT
        showModal()
    }
    
    @MainActor
    func showTagModal() {
        type = .TAG
        showModal()
    }
    
    @MainActor
    func showSettingsModal() {
        type = .SETTINGS
        showModal()
    }
    
    @MainActor
    func showShortcutModal() {
        type = .SHORTCUT
        showModal()
    }
    
    @MainActor
    func hideModal() {
        withAnimation {
            self.modalVisible = false
        }
    }
}

// MARK: - Helper functions
extension ModalHandler {
    private func showModal() {
        withAnimation {
            self.modalVisible = true
        }
    }
}
