//
//  ScriptManagerApp.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 03.02.23.
//

import SwiftUI
import KeyboardShortcuts
import AnyCodable

@main
struct ScriptManagerApp: App {
    let storage = StorageHandler()
    let window = NSWindow()
    
    @State var hideWelcomeScreen: Bool = true
    @StateObject private var appState = AppState()
    
    init() {
        do {
            // Reset all data
            //  storage.reset()
            
            // Open welcome-screen on first launch
            let hasLaunchedBefore = try storage.load(Bool.self, key: .FIRSTLAUNCH)?.get() ?? false
            if !hasLaunchedBefore {
                openWindow()
            }
        } catch {
            debugPrint("Failed to load first launch: \(error)")
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
            storage.save(value: AnyCodable(true), key: .FIRSTLAUNCH)
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
    private let dataHandler = DataHandler()
    private let scriptHandler = ScriptHandler()
    private let settingsHandler = SettingsHandler()
    
    private var savedShortcuts: [Shortcut] = []
    
    init() {
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
    
    func runScript(index: Int) {
        dataHandler.loadScripts()
        settingsHandler.loadSettings()
        
        savedShortcuts = settingsHandler.settings.shortcuts
        
        let id = savedShortcuts[index].scriptId
        
        if id != EmptyScript.id {
            if let script = dataHandler.scripts.first(where: { $0.id == id }) {
                NotificationHandler.sendStartNotification(name: script.name)
                
                Task {
                    await scriptHandler.runScript(script, test: false)
                }
            }
        }
    }
}
