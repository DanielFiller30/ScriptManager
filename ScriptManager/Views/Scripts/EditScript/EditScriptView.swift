//
//  EditScriptView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 20.02.23.
//

import SwiftUI

struct EditScriptView: View {
    @StateObject var viewModel: ScriptsViewModel
    
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
            
            HStack(alignment: .center) {
                DeleteChangesButton(viewModel: viewModel)
                
                Spacer()
                
                SaveChangesButton(viewModel: viewModel)
            }
            
        }
        .frame(height: 305)
    }
}

struct EditScriptView_Previews: PreviewProvider {
    static var previews: some View {
        EditScriptView(viewModel: ScriptsViewModel())
    }
}
