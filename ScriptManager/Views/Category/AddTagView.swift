//
//  AddTagView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 22.03.23.
//

import SwiftUI

struct AddTagView: View {
    @StateObject var viewModel: TagViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                Text("name-add-tag")
                    .font(.system(size: FontSize.text))
                
                Spacer()
                
                TextField("", text: $viewModel.name)
                    .frame(maxWidth: 120)
            }
            .padding(.bottom, Spacing.l)
            
            HStack(alignment: .center) {
                Text("color-add-tag")
                    .font(.system(size: FontSize.text))
                                
                Spacer()
                
                ColorPicker("", selection: $viewModel.badgeColor)
            }
            .padding(.bottom, Spacing.l)
                        
            // Save tag
            CustomButtonView(
                onClick: { viewModel.saveTag() },
                label: "save-tag",
                color: AppColor.Success,
                outlined: false,
                disabled: viewModel.name.isEmpty
            )
            .padding(.bottom, Spacing.m)
            
            // Cancel
            CustomButtonView(
                onClick: { viewModel.showAddTag.toggle() },
                label: "cancel",
                color: AppColor.Creme,
                outlined: true,
                disabled: false
            )
        }
        .padding(.all, Spacing.xl)
    }
}

struct AddTagView_Previews: PreviewProvider {
    static var previews: some View {
        AddTagView(viewModel: TagViewModel())
    }
}
