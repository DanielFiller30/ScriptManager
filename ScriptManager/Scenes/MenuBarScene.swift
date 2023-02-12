//
//  MenuBarScene.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 10.02.23.
//

import SwiftUI

struct MenuBarScene: Scene {
    var body: some Scene {
        MenuBarExtra("", image: "StatusBarIcon") {
            MainView()
        }
        .menuBarExtraStyle(.window)
    }
}
