//
//  MainView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 03.02.23.
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModelMain = MainViewModel()
    @StateObject private var viewModelScripts = ScriptsViewModel()

    var body: some View {
        VStack(spacing: Spacing.zero) {
            HeaderView()
            
            ScrollView() {                
                GroupView(
                    toggleVar: $viewModelMain.showAddScript,
                    toggle: {viewModelMain.showAddScript.toggle()},
                    label: "add-new-script",
                    info: "info-add-new-script",
                    view: AnyView(AddScriptView(viewModel: viewModelScripts, closeGroup: {
                        viewModelMain.showAddScript.toggle()
                    }))
                )
                .padding(.top, Spacing.m)
                
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
                
                ScriptsListView(viewModel: viewModelScripts)
                    .padding(.all, Spacing.xl)
                
                Spacer()
            }
            .background(Color.AppBg)
        }
        .frame(width: 300, height: 450)
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
