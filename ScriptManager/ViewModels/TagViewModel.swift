//
//  TagViewModel.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 22.03.23.
//

import Foundation
import Resolver
import SwiftUI

@Observable
class TagViewModel {
    @LazyInjected @ObservationIgnored private var tagHandler: TagHandlerProtocol
    @LazyInjected @ObservationIgnored private var scriptHandler: ScriptHandlerProtocol
    @LazyInjected @ObservationIgnored private var alertHandler: AlertHandlerProtocol
    @LazyInjected @ObservationIgnored private var hintHandler: HintHandlerProtocol
    @LazyInjected @ObservationIgnored var modalHandler: ModalHandlerProtocol

    var tags: [Tag] {
        tagHandler.tags
    }
    
    var selectedTag: UUID? {
        tagHandler.selectedTag
    }
    
    var name: String = ""
    var badgeColor: Color = AppColor.Primary
    
    func saveTag() {
        do {
            let colorData = try ColorConverter.encodeColor(color: badgeColor)
            let newTag: Tag = Tag(name: name, badgeColor: colorData)
            tagHandler.tags.append(newTag)
            tagHandler.saveTags()
                        
            resetForm()
            
            modalHandler.hideModal()
            hintHandler.showHint(String(localized: "save-tag-success"), type: .success)
        } catch {
            debugPrint("Failed to save new tag: \(error)")
            hintHandler.showHint(String(localized: "save-tag-failed"), type: .error)
        }
    }
    
    func setActiveTag(_ uuid: UUID?) {
        tagHandler.selectedTag = uuid
        
        if let uuid {
            // Set active tag
            scriptHandler.scripts = scriptHandler.savedScripts.filter({ $0.tagID == uuid })
        } else {
            // Reset tag
            scriptHandler.scripts = scriptHandler.savedScripts
        }
    }
    
    func resetForm() {
        name = ""
        badgeColor = AppColor.Primary
    }
}
