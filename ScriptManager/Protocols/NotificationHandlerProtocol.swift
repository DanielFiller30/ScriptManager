//
//  NotificationHandlerProtocol.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 05.04.23.
//

import Foundation

protocol NotificationHandlerProtocol {
    static func sendResultNotification(state: Bool, name: String)
    static func sendStartNotification(name: String)
}
