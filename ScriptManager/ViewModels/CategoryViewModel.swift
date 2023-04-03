//
//  CategoryViewModel.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 22.03.23.
//

import Foundation
import SwiftUI

class CategoryViewModel: ObservableObject {
    private let storage = StorageHandler()

    @Published var showAddCategory: Bool = false
    @Published var categories: [Category] = []
    
    @Published var name: String = ""
    @Published var badgeColor: Color = AppColor.Primary
    
    @Published var activeCategory: UUID?
    
    func saveCategory() {
        do {
            let colorData = try encodeColor(color: badgeColor)
            let newCategory: Category = Category(name: name, badgeColor: colorData)
            
            var savedCategories: [Category] = storage.loadCategories() ?? []
            savedCategories.append(newCategory)
                        
            storage.saveCategory(value: savedCategories)
            
            loadCategories()
            
            resetForm()
        } catch {
            debugPrint(error)
        }
    }
    
    func deleteCategory() {
        // Remove category entry
        categories = categories.filter {
            $0.id != activeCategory
        }
        
        // Update saved categories
        storage.saveCategory(value: categories)
    }
    
    func loadCategories() {
        categories = storage.loadCategories() ?? []
        categories.append(EmptyCategory)
    }
    
    func getDecodedColor(data: Data) -> Color {
        do {
            return try decodeColor(from: data)
        } catch {
            return AppColor.Primary
        }
    }
    
    func resetForm() {
        self.name = ""
        self.badgeColor = AppColor.Primary
        self.showAddCategory.toggle()
    }
}
