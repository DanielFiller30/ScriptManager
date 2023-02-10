//
//  ScriptManagerApp.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 03.02.23.
//

import SwiftUI

@main
struct ScriptManagerApp: App {
    let storage = StorageHandler()
    
    init() {
        // Reset all data
        //storage.reset()
    }
    
    var body: some Scene {
        MenuBarExtra("", image: "StatusBarIcon") {
            MainView()
        }
        .menuBarExtraStyle(.window)
    }
}
