//
//  TagHandlerTests.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 30.07.24.
//

@testable import ScriptManager

import Resolver
import Testing
import Foundation

final class TagHandlerTests {
    @LazyInjected private var sut: TagHandlerProtocol
    @LazyInjected private var storageHandler: StorageHandlerProtocol
    
    @Test("Save new tag") func saveTagTest() {
        let newTag = Tag(name: "", badgeColor: ColorConverter.defaultEncodedColor)
        
        storageHandler.tags.append(newTag)
        sut.saveTags()
        
        #expect(storageHandler.tags.first?.id == newTag.id)
    }
}
