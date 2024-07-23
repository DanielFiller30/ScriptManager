//
//  AlertHandler.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 17.05.24.
//

import Foundation
import Resolver
import SwiftUI

@Observable
class AlertHandler: AlertHandlerProtocol {
    var alertVisible: Bool = false
    
    var title: String = ""
    var message: String = ""
    var btnTitle: String = ""
    var action: () -> Void = {}
    var cancelVisible: Bool = true
    
    func showAlert(title: String, message: String, btnTitle: String, cancelVisible: Bool? = true, action: @escaping () -> Void) {
        self.title = title
        self.message = message
        self.btnTitle = btnTitle
        self.action = action
        
        withAnimation {
            self.alertVisible = true
        }
    }
    
    func hideAlert() {
        withAnimation {
            self.alertVisible = false
        }
    }
}
