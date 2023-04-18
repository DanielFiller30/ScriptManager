//
//  ShortcutModel.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 21.03.23.
//

import Foundation
import SwiftUI

struct Shortcut: Codable {
    var shortcutIndex: Int
    var scriptId: UUID
}

let EmptyShortcut = Shortcut(
    shortcutIndex: 9999,
    scriptId: EmptyScript.id
)
