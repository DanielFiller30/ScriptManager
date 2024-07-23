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
    var shortcuts: [Shortcut]
}

let DefaultSettings = Settings(
    shell: Shell(type: .zsh, path: "/bin/zsh", profile: ""),
    unicode: "en_US.UTF-8",
    logs: false,
    pathLogs: "",
    notifications: false,
    mainColor: ColorConverter.defaultEncodedColor,
    shortcuts: []
)
