//
//  MainView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 03.02.23.
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = ScriptViewModel()
    @StateObject private var settings = SettingsHandler()
    
    var body: some View {
        VStack(spacing: Spacing.zero) {
            HeaderView()
            
            GroupView(
                toggleVar: $viewModel.showAddScript,
                toggle: { toggleGroup() },
                label: viewModel.editMode ? "edit-script-title" : "add-new-script",
                info: viewModel.editMode ? nil : "info-add-new-script",
                padding: nil,
                animation: true
            ) {
                viewModel.editMode ? AnyView(EditScriptView(viewModel: viewModel)) : AnyView(AddScriptView(viewModel: viewModel))
            }
            .padding(.vertical, Spacing.l)
            .background(AppColor.AppBg)
            
            Divider()
            
            ScrollView() {
                ScriptsListView(viewModel: viewModel)
                    .padding(.all, Spacing.xl)
                
                Spacer()
            }
            .background(AppColor.AppBg)
        }
        .frame(width: 350, height: 450)
        .onAppear() {
            settings.loadSettings()
        }
        .environmentObject(settings)
        
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
