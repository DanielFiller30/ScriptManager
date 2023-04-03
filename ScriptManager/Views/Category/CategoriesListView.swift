//
//  CategoriesListView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 27.03.23.
//

import SwiftUI

struct CategoriesListView: View {
    @StateObject var vmCategory: CategoryViewModel
    @StateObject var vmScript: ScriptViewModel
    
    @State private var showDeleteAlert = false

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.l) {
            HStack(alignment: .center) {
                Text("categories-title")
                    .fontWeight(.bold)
                    .font(.system(size: FontSize.subTitle))
                
                Spacer()
                
                if vmCategory.activeCategory != nil {
                    Button {
                        showDeleteAlert.toggle()
                    } label: {
                        Image(systemName: "trash")
                            .resizable()
                            .frame(width: IconSize.s, height: IconSize.s)
                            .foregroundColor(AppColor.Danger)
                            .help("hint-remove-category")
                    }
                    .buttonStyle(.plain)
                    .alert("delete-category-title", isPresented: $showDeleteAlert) {
                        Button("cancel", role: .cancel) {}
                        Button("delete") {
                            // Remove category to script connection
                            vmScript.removeCategory(categoryId: vmCategory.activeCategory)
                            // Delete the category
                            vmCategory.deleteCategory()
                            vmCategory.activeCategory = nil
                            // Refresh scripts
                            vmScript.loadScripts()
                        }
                    } message: {
                        Text("delete-category-msg")
                    }
                }
                
                MenuSheetView(
                    hint: "add-new-category",
                    sheetTitle: "add-new-category",
                    onClick: {
                        vmCategory.showAddCategory.toggle()
                    },
                    onClose: {},
                    isPresented: $vmCategory.showAddCategory,
                    height: 270
                ) {
                    AddCategoryView(viewModel: vmCategory)
                }
            }
            .padding(.bottom, Spacing.l)
            
            ScrollView(.horizontal) {
                HStack(spacing: Spacing.l) {
                    if (!vmCategory.categories.isEmpty) {
                        ForEach($vmCategory.categories) { $category in
                            if category.id != EmptyCategory.id {
                                Button {
                                    withAnimation() {
                                        vmScript.loadScripts()
                                        
                                        if category.id == vmCategory.activeCategory {
                                            vmCategory.activeCategory = nil
                                        } else {
                                            debugPrint("Category: \(category.id)")
                                            vmCategory.activeCategory = category.id
                                            debugPrint("ACTIVE: \(category.id == vmCategory.activeCategory)")

                                            vmScript.filterScripts(category: category)
                                        }
                                    }
                                } label: {
                                    BadgeView(
                                        color: vmCategory.getDecodedColor(data: category.badgeColor),
                                        title: category.name,
                                        active: category.id == vmCategory.activeCategory
                                    )
                                }
                                .buttonStyle(.plain)
                            }                            
                        }
                    } else {
                        Text("empty-categories")
                            .font(.system(size: FontSize.text))
                            .foregroundColor(AppColor.Creme)
                            .frame(maxWidth: .infinity)
                            .multilineTextAlignment(.center)
                        
                        Spacer()
                    }
                }
                .padding(.bottom, Spacing.xl)
            }
        }
        .padding(.horizontal, Spacing.xl)
        .padding(.top, Spacing.xl)
        .onAppear {
            vmCategory.loadCategories()
        }
    }
}

struct CategoriesListView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesListView(vmCategory: CategoryViewModel(), vmScript: ScriptViewModel())
    }
}
