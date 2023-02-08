//
//  ShellTypeModel.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 06.02.23.
//

import Foundation

struct Shell: Identifiable, Codable {
    var id: UUID = UUID()
    var type: ShellType
    var path: String
    var profile: String?
}

enum ShellType: String, Codable {
    case zsh = "zsh"
    case bash = "bash"
}

let Shells: [Shell] = [
    Shell(type: .zsh, path: "/bin/zsh", profile: "/.zshrc"),
    Shell(type: .bash, path: "/bin/bash", profile: "/.bash_profile")
]
