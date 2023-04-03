//
//  AddCategoryView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 22.03.23.
//

import SwiftUI

struct AddCategoryView: View {
    @StateObject var viewModel: CategoryViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                Text("name-add-category")
                    .font(.system(size: FontSize.text))
                
                Spacer()
                
                TextField("", text: $viewModel.name)
                    .frame(maxWidth: 120)
            }
            .padding(.bottom, Spacing.l)
            
            HStack(alignment: .center) {
                Text("color-add-category")
                    .font(.system(size: FontSize.text))
                                
                Spacer()
                
                ColorPicker("", selection: $viewModel.badgeColor)
            }
            .padding(.bottom, Spacing.l)
                        
            // Save category
            CustomButtonView(
                onClick: { viewModel.saveCategory() },
                label: "save-category",
                color: AppColor.Success,
                outlined: false,
                disabled: viewModel.name.isEmpty
            )
            .padding(.bottom, Spacing.m)
            
            // Cancel
            CustomButtonView(
                onClick: { viewModel.showAddCategory.toggle() },
                label: "cancel",
                color: AppColor.Creme,
                outlined: true,
                disabled: false
            )
        }
        .padding(.all, Spacing.xl)
    }
}

struct AddCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        AddCategoryView(viewModel: CategoryViewModel())
    }
}
