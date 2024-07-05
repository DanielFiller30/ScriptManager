//
//  ShortcutModel.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 21.03.23.
//

import Foundation
import SwiftUI

struct Shortcut: Codable, Hashable {    
    var shortcutIndex: Int
    var scriptId: UUID
    var keys: String
}

let EmptyShortcut = Shortcut(
    shortcutIndex: 9999,
    scriptId: EmptyScript.id,
    keys: "CMD"
)
