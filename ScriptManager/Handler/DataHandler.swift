//
//  DataHandler.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 04.04.23.
//

import Foundation

class DataHandler: DataHandlerProtocol {    
    static var shared = DataHandler()
    
    internal let storage = StorageHandler()
    
    @Published var tags: [Tag] = []
    @Published var scripts: [Script] = []
    
    @Published var selectedTag: UUID? = nil
    
    required init() {
        // Initial loading data
        loadScripts()
        loadTags()
    }
    
    func loadScripts() {
        do {
            scripts = try storage.load([Script].self, key: .SCRIPTS)?.get() ?? []
        } catch {
            debugPrint("Loading scripts failed: \(error)")
        }
    }
    
    func loadTags() {
        do {
            tags = try storage.load([Tag].self, key: .TAG)?.get() ?? []
        } catch {
            debugPrint("Loading tags failed: \(error)")
        }
    }
}
