//
//  AlertHandlerProtocol.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 17.05.24.
//

import Foundation

protocol AlertHandlerProtocol {
    var alertVisible: Bool { get }
    var title: String { get }
    var message: String { get }
    var btnTitle: String { get }
    var cancelVisible: Bool { get }
    var action: () -> Void { get }
    
    func showAlert(title: String, message: String, btnTitle: String, cancelVisible: Bool?, action: @escaping () -> Void)
    func hideAlert()
}
