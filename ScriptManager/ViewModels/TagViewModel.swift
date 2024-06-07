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
        } catch {
            debugPrint("Failed to save new tag: \(error)")
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
    
    func showDeleteAlert(_ tagId: UUID) {
        alertHandler.showAlert(
            title: String(localized: "delete-tag-title"),
            message: String(localized: "delete-tag-msg"),
            btnTitle: String(localized: "delete"),
            action: {
                self.deleteTag(tagId: tagId)
                self.alertHandler.hideAlert()
            }
        )
    }
    
    func deleteTag(tagId: UUID) {
        // Remove tag from scripts
        scriptHandler.scripts = scriptHandler.savedScripts
                
        for (index, script) in scriptHandler.scripts.enumerated() {
            if script.tagID == tagId {
                scriptHandler.scripts[index].tagID = EmptyTag.id
            }
        }
         
        scriptHandler.saveScripts()
        
        // Delete tag
        tagHandler.tags = tagHandler.tags.filter {
            $0.id != tagId
        }
                
        tagHandler.saveTags()
        tagHandler.selectedTag = nil
    }
    
    func resetForm() {
        name = ""
        badgeColor = AppColor.Primary
        modalHandler.hideModal()
    }
}
