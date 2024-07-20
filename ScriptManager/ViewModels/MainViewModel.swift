//
//  MainViewModel.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 17.05.24.
//

import Foundation
import Resolver

@Observable
class MainViewModel {
    @LazyInjected @ObservationIgnored private var alertHandler: AlertHandlerProtocol
    @LazyInjected @ObservationIgnored private var modalHandler: ModalHandlerProtocol
    @LazyInjected @ObservationIgnored var scriptHandler: ScriptHandlerProtocol
    @LazyInjected @ObservationIgnored var hintHandler: HintHandlerProtocol

    var alertVisible: Bool {
        alertHandler.alertVisible
    }
    
    var modalVisible: Bool {
        modalHandler.modalVisible
    }
    
    var hintVisible: Bool {
        hintHandler.hintVisible
    }
    
    var modalType: ModalType {
        modalHandler.type
    }
}
