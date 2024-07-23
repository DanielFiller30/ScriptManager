//
//  TagHandler.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 28.03.24.
//

import Foundation
import Resolver

@Observable
class TagHandler: TagHandlerProtocol {
    @LazyInjected @ObservationIgnored private var storageHandler: StorageHandlerProtocol
        
    var tags: [Tag] = [] {
        didSet {
            storageHandler.tags = tags
        }
    }
    
    var selectedTag: UUID? = nil
    
    init() {
        tags = storageHandler.tags
    }
    
    func saveTags() {
        storageHandler.tags = tags
    }
}
