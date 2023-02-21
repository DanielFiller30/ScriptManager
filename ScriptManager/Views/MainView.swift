//
//  MainView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 03.02.23.
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = ScriptsViewModel()
    
    var body: some View {
        VStack(spacing: Spacing.zero) {
            HeaderView()
            
            GroupView(
                toggleVar: $viewModel.showAddScript,
                toggle: { toggleGroup() },
                label: viewModel.editMode ? "edit-script-title" : "add-new-script",
                info: viewModel.editMode ? "" : "info-add-new-script",
                view: viewModel.editMode ? AnyView(EditScriptView(viewModel: viewModel)) : AnyView(AddScriptView(viewModel: viewModel))
            )
            .padding(.vertical, Spacing.l)
            .background(Color.AppBg)
            
            Divider()
            
            /* TODO: Add group-feature
             GroupView(
             toggleVar: $viewModelMain.showAddGroup,
             toggle: {viewModelMain.showAddGroup.toggle()},
             label: "add-new-group",
             info: "info-add-new-group",
             view: AnyView(AddGroupView(closeGroup: {
             viewModelMain.showAddGroup.toggle()
             }))
             )
             
             Divider()
             */
            
            ScrollView() {
                ScriptsListView(viewModel: viewModel)
                    .padding(.all, Spacing.xl)
                
                Spacer()
            }
            .background(Color.AppBg)
        }
        .frame(width: 350, height: 450)
        
    }
    
    func toggleGroup() {
        if viewModel.editMode {
            viewModel.closeEdit()            
        } else {
            viewModel.showAddScript.toggle()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
