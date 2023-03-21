//
//  DefaultSettings.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 09.02.23.
//

import Foundation

struct DefaultSettings {
    static var id: UUID = UUID()
    static var shell: Shell = Shell(type: .zsh, path: "/bin/zsh", profile: "")
    static var logs: Bool = false
    static var pathLogs: String = ""
    static var unicode: String = "en_US.UTF-8"
    static var notifications: Bool = false
    static var mainColor: Data? = {
        do {
            return try encodeColor(color: AppColor.Primary)
        } catch {
            debugPrint("Failed to load default color.")
            return nil
        }
    }()
    static var shortcuts: [Shortcut] = []
}
