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
    @LazyInjected @ObservationIgnored private var scriptHandler: ScriptHandlerProtocol
    @LazyInjected @ObservationIgnored private var alertHandler: AlertHandlerProtocol
    @LazyInjected @ObservationIgnored private var hintHandler: HintHandlerProtocol
    @LazyInjected @ObservationIgnored var modalHandler: ModalHandlerProtocol
    @LazyInjected @ObservationIgnored var tagHandler: TagHandlerProtocol
    
    var tags: [Tag] {
        tagHandler.tags
    }
    
    var selectedTag: UUID? {
        tagHandler.selectedTag
    }
    
    var editMode: Bool {
        tagHandler.editMode
    }            
    
    @MainActor
    func saveTag() {
        do {
            let colorData = try ColorConverter.encodeColor(color: tagHandler.editColor)
            let newTag: Tag = Tag(name: tagHandler.editTag.name, badgeColor: colorData)
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
    
    @MainActor
    func saveChangedTag() {
        do {
            let editTag = tagHandler.editTag
            let index: Int? = tagHandler.tags.firstIndex(where: { $0.id == editTag.id })
            
            guard let index else { return }
            var selectedTag = tagHandler.tags[index]
            selectedTag.name = editTag.name
            
            let colorData = try ColorConverter.encodeColor(color: tagHandler.editColor)
            selectedTag.badgeColor = colorData
            
            tagHandler.tags[index] = selectedTag
            tagHandler.saveTags()
            
            tagHandler.editMode = false
            resetForm()
            
            modalHandler.hideModal()
            hintHandler.showHint(String(localized: "save-edit-tag-success"), type: .success)
        } catch {
            hintHandler.showHint(String(localized: "save-changed-tag-failed"), type: .error)
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
    
    func hideModal() {
        resetForm()
        modalHandler.hideModal()
    }
    
    func resetForm() {
        tagHandler.editMode = false
        tagHandler.editTag = EmptyTag
        tagHandler.editColor = AppColor.Primary
    }
}
