//
//  HeaderViewModel.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 18.07.24.
//

import Resolver
import SwiftUI

@Observable
class HeaderViewModel {
    @LazyInjected @ObservationIgnored private var tagHandler: TagHandlerProtocol
    @LazyInjected @ObservationIgnored private var alertHandler: AlertHandlerProtocol
    @LazyInjected @ObservationIgnored var scriptHandler: ScriptHandlerProtocol
    @LazyInjected @ObservationIgnored var modalHandler: ModalHandlerProtocol

    var selectedTag: UUID? {
        tagHandler.selectedTag
    }
    
    func getTagColor() -> Color {
        var iconColor = Color.white
        
        do {
            iconColor = try ColorConverter.decodeColor(from: tagHandler.tags.first { 
                $0.id == tagHandler.selectedTag }?.badgeColor ?? EmptyTag.badgeColor)
        } catch {
            // Fallback default color
        }
        
        return iconColor
    }
    
    func showDeleteTagAlert() {
        alertHandler.showAlert(
            title: String(localized: "delete-tag-title"),
            message: String(localized: "delete-tag-msg"),
            btnTitle: String(localized: "delete"),
            action: {
                self.deleteTag()
                self.alertHandler.hideAlert()
            }
        )
    }
    
    private func deleteTag() {
        // Remove tag from scripts
        scriptHandler.scripts = scriptHandler.savedScripts
                
        for (index, script) in scriptHandler.scripts.enumerated() {
            if script.tagID == selectedTag {
                scriptHandler.scripts[index].tagID = EmptyTag.id
            }
        }
         
        scriptHandler.saveScripts()
        
        // Delete tag
        tagHandler.tags = tagHandler.tags.filter {
            $0.id != selectedTag
        }
                
        tagHandler.saveTags()
        tagHandler.selectedTag = nil
    }
}

