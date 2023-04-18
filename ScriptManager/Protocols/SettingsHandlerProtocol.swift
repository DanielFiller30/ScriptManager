//
//  SettingsHandlerProtocol.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 05.04.23.
//

import Foundation
import AnyCodable
import SwiftUI

protocol SettingsHandlerProtocol: ObservableObject {
    var storage: StorageHandler { get }
    var settings: Settings { get }
    
    var showingPopover: Bool { get }
    var showDeleteAlert: Bool { get }
    
    var homeDir: String { get }
    var shell: ShellType { get }
    var shellPath: String { get }
    var profilePath: String { get }
    var unicode: String { get }
    var loggingState: Bool { get }
    var logsPath: String { get }
    var notificationState: Bool { get }
    var mainColor: Color { get }
    var selectedScript1: UUID { get }
    var selectedScript2: UUID { get }
    var selectedScript3: UUID { get }
    var selectedScript4: UUID { get }
    var selectedScript5: UUID { get }
    
    init()
    func loadSettings()
    func initSettings()
    
    func loadUserDir() -> String
    func loadLogsDir() -> String
    
    func reset()
    func activateNotifications()
    func saveSettings()
}
