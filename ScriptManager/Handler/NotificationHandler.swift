//
//  NotificationHandler.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 05.04.23.
//

import Foundation
import UserNotifications

class NotificationHandler: NotificationHandlerProtocol {
    static func sendResultNotification(state: Bool, name: String) {
        let content = UNMutableNotificationContent()
        content.title = state ? String(localized: "notification-successfull-title \(name)") : String(localized: "notification-failed-title \(name)")
        content.subtitle = state ? String(localized: "notification-successfull-subtitle") : String(localized: "notification-failed-subtitle")
        content.sound = UNNotificationSound.default
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)
        UNUserNotificationCenter.current().add(request)
    }
    
    static func sendStartNotification(name: String) {
        let content = UNMutableNotificationContent()
        content.title = String(localized: "notification-start-title \(name)")
        content.subtitle = String(localized: "notification-start-subtitle")
        content.sound = UNNotificationSound.default
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)
        UNUserNotificationCenter.current().add(request)
    }
}
