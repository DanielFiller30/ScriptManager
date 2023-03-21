//
//  ScriptManagerApp.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 03.02.23.
//

import SwiftUI
import KeyboardShortcuts

@main
struct ScriptManagerApp: App {
    let storage = StorageHandler()
    let window = NSWindow()
    
    @State var hideWelcomeScreen: Bool = true
    @StateObject private var appState = AppState()
    
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

@MainActor
final class AppState: ObservableObject {
    let scriptHandler = ScriptHandler()
    let storageHandler = StorageHandler()
    
    init() {
        scriptHandler.loadScripts()
       
        let savedShortcuts = storageHandler.loadSettings().shortcuts
        
        KeyboardShortcuts.onKeyUp(for: .runScript1) {
            debugPrint("Run Script 1")
            guard let script = self.getScript(id: savedShortcuts[0].scriptId) else { return }
            self.runScript(script: script)
        }
        
        KeyboardShortcuts.onKeyUp(for: .runScript2) {
            debugPrint("Run Script 2")
            guard let script = self.getScript(id: savedShortcuts[1].scriptId) else { return }
            self.runScript(script: script)
        }
        
        KeyboardShortcuts.onKeyUp(for: .runScript3) {
            debugPrint("Run Script 3")
            guard let script = self.getScript(id: savedShortcuts[2].scriptId) else { return }
            self.runScript(script: script)
        }
        
        KeyboardShortcuts.onKeyUp(for: .runScript4) {
            debugPrint("Run Script 4")
            guard let script = self.getScript(id: savedShortcuts[3].scriptId) else { return }
            self.runScript(script: script)
        }
        
        KeyboardShortcuts.onKeyUp(for: .runScript5) {
            debugPrint("Run Script 5")
            guard let script = self.getScript(id: savedShortcuts[4].scriptId) else { return }
            self.runScript(script: script)
        }
    }
    
    func getScript(id: UUID) -> Script? {
        if let script = scriptHandler.scripts.first(where: { $0.id == id }) {
            return script
        } else {
            return nil
        }
    }
    
    func runScript(script: Script) {
        self.scriptHandler.sendStartNotification(name: script.name)
        
        Task {
            await self.scriptHandler.runScript(script, test: false)
        }
    }
}
