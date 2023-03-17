//
//  SettingsModel.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 06.02.23.
//

import Foundation
import SwiftUI

struct Settings: Identifiable, Codable {
    var id = UUID()
    var shell: Shell
    var unicode: String
    var logs: Bool
    var pathLogs: String
    var notifications: Bool
    var mainColor: Data
}
