//
//  EditScriptView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 20.02.23.
//

import SwiftUI

struct EditScriptView: View {
    @StateObject var viewModel: ScriptViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            
            VStack(alignment: .leading) {
                Text("name-add-script")
                    .font(.system(size: FontSize.text))
                
                TextField("", text: $viewModel.name)
                
            }
            .padding(.bottom, Spacing.l)
            
            VStack(alignment: .leading) {
                Text("icon-script")
                    .font(.system(size: FontSize.text))
                
                IconPickerView(viewModel: viewModel)
            }
            .padding(.bottom, Spacing.l)
            
            HStack(alignment: .center) {
                Text("category-script")
                    .font(.system(size: FontSize.text))
                
                Spacer()
                
                CategoryPickerView(viewModel: viewModel)
            }
            
            VStack(alignment: .leading) {
                HStack(alignment: .center) {
                    Text("path-add-script")
                        .font(.system(size: FontSize.text))
                    
                    HintView(title: "hint-script-title", text: "hint-script-text")
                }
                
                TextField("cd /Desktop/ sh ...", text: $viewModel.command, axis: .vertical)
                    .lineLimit(4, reservesSpace: true)
                
            }.padding(.bottom, Spacing.l)
            
            Spacer()
            
            // Save changed script
            CustomButtonView(
                onClick: { viewModel.updateScript() },
                label: "edit-save",
                color: AppColor.Success,
                outlined: false,
                disabled: false
            )
            .padding(.bottom, Spacing.m)
            
            // Cancel
            CustomButtonView(
                onClick: {
                    viewModel.closeEdit()
                    viewModel.showAddScript.toggle()
                },
                label: "cancel",
                color: AppColor.Creme,
                outlined: true,
                disabled: false
            )
        }
        .padding(.all, Spacing.xl)
    }
}

struct EditScriptView_Previews: PreviewProvider {
    static var previews: some View {
        EditScriptView(viewModel: ScriptViewModel())
    }
}
