//
//  TagViewModel.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 22.03.23.
//

import Foundation
import SwiftUI
import AnyCodable

class TagViewModel: ObservableObject {
    internal let storage = StorageHandler()
    internal let dataHandler = DataHandler.shared

    @Published var showAddTag: Bool = false
    
    @Published var name: String = ""
    @Published var badgeColor: Color = AppColor.Primary
        
    func saveTag() {
        do {
            let colorData = try ColorHandler.encodeColor(color: badgeColor)
            let newTag: Tag = Tag(name: name, badgeColor: colorData)
            
            dataHandler.tags.append(newTag)
            storage.save(value: AnyCodable(dataHandler.tags), key: .TAG)
                        
            resetForm()
        } catch {
            debugPrint("Failed to save new tag: \(error)")
        }
    }
    
    func deleteTag() {
        // Remove tag entry
        dataHandler.tags = dataHandler.tags.filter {
            $0.id != dataHandler.selectedTag
        }
        
        // Update saved tags
        storage.save(value: AnyCodable(dataHandler.tags), key: .TAG)
    }
    
    func resetForm() {
        name = ""
        badgeColor = AppColor.Primary
        showAddTag.toggle()
    }
}
