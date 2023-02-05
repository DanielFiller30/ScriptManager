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
        VStack {
            HeaderView()
            
            ScrollView() {                
                GroupView(
                    toggleVar: $viewModelMain.showAddScript,
                    toggle: {viewModelMain.showAddScript.toggle()},
                    label: String(localized: "add-new-script"),
                    info: String(localized: "info-add-new-script"),
                    view: AnyView(AddScriptView(viewModel: viewModelScripts, closeGroup: {
                        viewModelMain.showAddScript.toggle()
                    }))
                )
                
                Divider()
                
                GroupView(
                    toggleVar: $viewModelMain.showAddGroup,
                    toggle: {viewModelMain.showAddGroup.toggle()},
                    label: String(localized: "add-new-group"),
                    info: String(localized: "info-add-new-group"),
                    view: AnyView(AddGroupView(closeGroup: {
                        viewModelMain.showAddGroup.toggle()
                    }))
                )
                
                Divider()
                
                ScriptsListView(viewModel: viewModelScripts)
                    .padding(.all, Spacing.xl)
                
                Spacer()
            }
        }
        .frame(width: 300, height: 450)
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
