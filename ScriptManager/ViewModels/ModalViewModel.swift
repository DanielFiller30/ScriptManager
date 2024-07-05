//
//  ModalViewModel.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 07.06.24.
//

import Foundation
import Resolver

@Observable
class ModalViewModel {
    @Injected @ObservationIgnored var modalHandler: ModalHandlerProtocol
    
    var modalType: ModalType {
        modalHandler.type
    }
    
    var modalTitle: String {
        switch modalHandler.type {
        case .ADD_SCRIPT:
            String(localized: "add-new-script")
        case .EDIT_SCRIPT:
            String(localized: "edit-script-title")
        case .TAG:
            String(localized: "add-new-tag")
        case .SETTINGS:
            String(localized: "settings")
        case .SHORTCUT:
            String(localized: "shortcut")
        }
    }
}
