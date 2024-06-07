//
//  ModalHandlerProtocol.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 07.06.24.
//

import Foundation

protocol ModalHandlerProtocol {
    var modalVisible: Bool { get }
    var type: ModalType { get }
    
    func showAddScriptModal()
    func showEditScriptModal()
    func showTagModal()
    func showSettingsModal()
    
    func hideModal()
}

enum ModalType {
    case ADD_SCRIPT
    case EDIT_SCRIPT
    case TAG
    case SETTINGS
}
