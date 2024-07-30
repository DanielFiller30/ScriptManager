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
    
    func showModal(_ type: ModalType) {
        self.type = type
        
        withAnimation {
            self.modalVisible = true
        }
    }
    
    func hideModal() {
        withAnimation {
            self.modalVisible = false
        }
    }
}
