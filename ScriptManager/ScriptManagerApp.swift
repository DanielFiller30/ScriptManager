//
//  ScriptManagerApp.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 03.02.23.
//

import KeyboardShortcuts
import Resolver
import SwiftUI

@main
struct ScriptManagerApp: App {
    @Injected private var storageHandler: StorageHandlerProtocol
    
    let window = NSWindow()
    
    @State var hideWelcomeScreen: Bool = true
    @StateObject private var appState = AppState()
    
    init() {        
        // Open welcome-screen on first launch
        if storageHandler.firstLaunch {
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
            storageHandler.setFirstLaunchToFalse()
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

@MainActor
final class AppState: ObservableObject {
    @Injected private var storageHandler: StorageHandlerProtocol
    @Injected private var scriptHandler: ScriptHandlerProtocol
    
    private var savedShortcuts: [Shortcut] = []
    
    init() {
        // Initialize keyboard shortcuts
        KeyboardShortcuts.onKeyUp(for: .runScript1) {
            debugPrint("Run Script 1")
            self.runScript(index: 0)
        }
        
        KeyboardShortcuts.onKeyUp(for: .runScript2) {
            debugPrint("Run Script 2")
            self.runScript(index: 1)
        }
        
        KeyboardShortcuts.onKeyUp(for: .runScript3) {
            debugPrint("Run Script 3")
            self.runScript(index: 2)
        }
        
        KeyboardShortcuts.onKeyUp(for: .runScript4) {
            debugPrint("Run Script 4")
            self.runScript(index: 3)
        }
        
        KeyboardShortcuts.onKeyUp(for: .runScript5) {
            debugPrint("Run Script 5")
            self.runScript(index: 4)
        }
    }
    
    private func runScript(index: Int) {
        savedShortcuts = storageHandler.settings.shortcuts
        
        guard !savedShortcuts.isEmpty else { return }
        let id = savedShortcuts[index].scriptId
        
        if id != EmptyScript.id {
            if let script = storageHandler.scripts.first(where: { $0.id == id }) {
                NotificationHandler.sendStartNotification(name: script.name)
                
                Task {
                    await scriptHandler.runScript(script, test: false)
                }
            }
        }
    }
    
    /* // Reset function for debugging and testing
    private func resetShortcuts() {
        KeyboardShortcuts.reset(.runScript1)
        KeyboardShortcuts.reset(.runScript2)
        KeyboardShortcuts.reset(.runScript3)
        KeyboardShortcuts.reset(.runScript4)
        KeyboardShortcuts.reset(.runScript5)
    }*/
}
