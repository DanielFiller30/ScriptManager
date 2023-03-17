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
    let window = NSWindow()
    
    @State var hideWelcomeScreen: Bool = true

    init() {
        // Reset all data
        //storage.reset()
        
        // Open welcome-screen on first launch
        let hasLaunchedBefore = storage.loadFirstLaunch()
        if !hasLaunchedBefore {
            openWindow()
        }
    }
    
    func openWindow() {
        let contentView = WelcomeView(close: { closeWindow() }, hideWelcomeScreen: $hideWelcomeScreen)
        window.contentViewController = NSHostingController(rootView: contentView)
        window.styleMask = [.closable, .titled]
        window.center()
        window.orderFrontRegardless()
        window.makeKeyAndOrderFront(nil)
    }
    
    func closeWindow() {
        if hideWelcomeScreen {
            storage.updateFirstLaunch()
        }
        
        window.close()
    }
    
    var body: some Scene {        
        MenuBarExtra("", image: "StatusBarIcon") {
            MainView()
        }
        .menuBarExtraStyle(.window)
    }
}
