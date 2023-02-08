//
//  SettingsViewModel.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 06.02.23.
//

import Foundation

class SettingsViewModel: ObservableObject {
    private let storage = StorageHandler()
    
    @Published var showingPopover: Bool = false
    @Published var showDeleteAlert: Bool = false

    @Published var shell: ShellType = .zsh
    @Published var shellPath: String = "/bin/zsh"
    @Published var profilePath: String = ""
    @Published var unicode: String = "en_US.UTF-8"
    @Published var homeDir: String = ""
    
    func loadUserDir() {
        let homeDirURL = FileManager.default.homeDirectoryForCurrentUser
        let dir = homeDirURL.relativePath
        
        homeDir = dir
        profilePath = "\(dir)./zshrc"
    }
    
    func reset() {
        storage.reset()
    }
    
    func save() {
        let settings = Settings(shell: Shell(type: shell, path: shellPath, profile: profilePath), unicode: unicode)
        storage.saveSettings(value: settings)
        
        showingPopover.toggle()
    }
}
