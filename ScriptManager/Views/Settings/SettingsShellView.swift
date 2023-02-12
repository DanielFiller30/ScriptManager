//
//  SettingsShellView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 10.02.23.
//

import SwiftUI

struct SettingsShellView: View {
    @StateObject var viewModel: SettingsViewModel
    
    @State var showHintShell: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack(alignment: .center) {
                Text("shell-type")
                    .font(.system(size: FontSize.text))
                
                HintView(title: String(localized: "hint-shell-title"), text: String(localized: "hint-shell-text"))
                
                Spacer()
                
                Picker("", selection: $viewModel.shell) {
                    ForEach(Shells) { shell in
                        Text(shell.type.rawValue)
                            .tag(shell.type)
                    }
                }
                .onChange(of: viewModel.shell) { type in
                    changeShellType(stype: type)
                }
                .frame(width: 110)
            }
            .padding(.bottom, Spacing.l)
            
            HStack(alignment: .center) {
                Text("path-shell")
                    .font(.system(size: FontSize.text))
                
                Spacer()
                
                TextField("", text: $viewModel.shellPath)
                    .frame(width: 100)
            }
            .padding(.bottom, Spacing.l)
            
            HStack(alignment: .center) {
                Text("path-profile")
                    .font(.system(size: FontSize.text))
                
                HintView(title: String(localized: "hint-profile-title"), text: String(localized: "hint-profile-text"))

                Spacer()
                
                TextField("", text: $viewModel.profilePath)
                    .frame(width: 100)
            }
        }
        .padding(.vertical, Spacing.m)
        .padding(.horizontal, Spacing.xl)
        
    }
    
    func changeShellType(stype: ShellType) {
        let shell: Shell = Shells.filter{ $0.type == viewModel.shell }.first!
        viewModel.shellPath = shell.path
        viewModel.profilePath = viewModel.homeDir + (shell.profile ?? "")
    }
}

struct SettingsShellView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsShellView(viewModel: SettingsViewModel())
    }
}
