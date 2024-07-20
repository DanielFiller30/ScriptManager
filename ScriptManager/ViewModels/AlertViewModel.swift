//
//  AlertViewModel.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 17.05.24.
//

import Foundation
import Resolver

@Observable
class AlertViewModel {
    @LazyInjected @ObservationIgnored private var alertHandler: AlertHandlerProtocol
    
    var title: String {
        alertHandler.title
    }
    
    var message: String {
        alertHandler.message
    }
    
    var btnTitle: String {
        alertHandler.btnTitle
    }
    
    var cancelVisible: Bool {
        alertHandler.cancelVisible
    }
    
    var action: () -> () {
        alertHandler.action
    }
    
    func hideAlert() {
        alertHandler.hideAlert()
    }
}
