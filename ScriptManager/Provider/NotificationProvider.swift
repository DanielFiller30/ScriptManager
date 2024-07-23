//
//  NotificationHandler.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 05.04.23.
//

import Foundation
import UserNotifications

class NotificationHandler: NotificationHandlerProtocol {
    /// Send a notification with the result of the finished script
    ///  - Parameter state: The finished state result for the script
    ///  - Parameter name: The name of the finished script
    static func sendResultNotification(state: Bool, name: String) {
        let content = UNMutableNotificationContent()
        content.title = state ? String(localized: "notification-successfull-title \(name)") : String(localized: "notification-failed-title \(name)")
        content.subtitle = state ? String(localized: "notification-successfull-subtitle") : String(localized: "notification-failed-subtitle")
        content.sound = UNNotificationSound.default
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)
        UNUserNotificationCenter.current().add(request)
    }
    
    /// Send a notification when the script starts running, especially for scripts triggered by a shortcut
    /// - Parameter name: Name of the running script
    static func sendStartNotification(name: String) {
        let content = UNMutableNotificationContent()
        content.title = String(localized: "notification-start-title \(name)")
        content.subtitle = String(localized: "notification-start-subtitle")
        content.sound = UNNotificationSound.default
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)
        UNUserNotificationCenter.current().add(request)
    }
}
