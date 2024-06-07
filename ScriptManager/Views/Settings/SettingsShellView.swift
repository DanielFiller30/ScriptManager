//
//  SettingsShellView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 10.02.23.
//

import SwiftUI

struct SettingsShellView: View {
    @State private var viewModel = SettingsViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack(alignment: .center) {
                Text("shell-type")
                    .font(.system(size: FontSize.text))
                
                HintView(title: "hint-shell-title", text: "hint-shell-text")
                
                Spacer()
                
//                Picker("", selection: $viewModel.settingsHandler.settings.shell) {
//                    ForEach(Shells) { shell in
//                        Text(shell.type.rawValue)
//                            .tag(shell.type)
//                    }
//                }
//                .onChange(of: viewModel.settingsHandler.settings.shell) { type, _ in
//                    changeShellType(stype: type)
//                }
//                .frame(width: 160)
            }
            .padding(.bottom, Spacing.l)
            
            HStack(alignment: .center) {
                Text("path-shell")
                    .font(.system(size: FontSize.text))
                
                Spacer()
                
                TextField("", text: $viewModel.settingsHandler.settings.shell.path)
                    .frame(width: 150)
            }
            .padding(.bottom, Spacing.l)
            
            HStack(alignment: .center) {
                Text("path-profile")
                    .font(.system(size: FontSize.text))
                
                HintView(title: "hint-profile-title", text: "hint-profile-text")
                
                Spacer()
                
//                TextField("", text: $viewModel.settingsHandler.settings.shell.profile)
//                    .frame(width: 150)
            }
        }
        .padding(.vertical, Spacing.m)        
    }
    
    func changeShellType(stype: ShellType) {
        let shell: Shell = Shells.filter{ $0.type == viewModel.settingsHandler.settings.shell.type }.first!
        viewModel.settingsHandler.settings.shell.path = shell.path
        viewModel.settingsHandler.settings.shell.profile = viewModel.homeDir + (shell.profile ?? "")
    }
}

struct SettingsShellView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsShellView()
    }
}
