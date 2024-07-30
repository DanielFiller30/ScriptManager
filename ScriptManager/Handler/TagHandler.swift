//
//  TagHandler.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 28.03.24.
//

import Foundation
import Resolver
import SwiftUI

@Observable
class TagHandler: TagHandlerProtocol {
    var editTag = Tag(name: "", badgeColor: ColorConverter.defaultEncodedColor)
    var editColor: Color = AppColor.Primary
    
    @LazyInjected @ObservationIgnored private var storageHandler: StorageHandlerProtocol
        
    var tags: [Tag] = [] {
        didSet {
            storageHandler.tags = tags
        }
    }
    
    var editMode: Bool = false
    var selectedTag: UUID? = nil
    
    init() {
        tags = storageHandler.tags
    }
    
    func saveTags() {
        storageHandler.tags = tags
    }
}
