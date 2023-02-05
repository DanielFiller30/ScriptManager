//
//  MainViewModel.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 03.02.23.
//

import Foundation

class MainViewModel: ObservableObject {
    private let storage = StorageHandler()
    
    @Published var showAddScript: Bool = false
    @Published var showAddGroup: Bool = false
}
