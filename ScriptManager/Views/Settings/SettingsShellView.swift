//
//  SettingsShellView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 10.02.23.
//

import SwiftUI

struct SettingsShellView: View {
    @EnvironmentObject var settings: SettingsHandler
    
    @State var showHintShell: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack(alignment: .center) {
                Text("shell-type")
                    .font(.system(size: FontSize.text))
                
                HintView(title: "hint-shell-title", text: "hint-shell-text")
                
                Spacer()
                
                Picker("", selection: $settings.shell) {
                    ForEach(Shells) { shell in
                        Text(shell.type.rawValue)
                            .tag(shell.type)
                    }
                }
                .onChange(of: settings.shell) { type in
                    changeShellType(stype: type)
                }
                .frame(width: 160)
            }
            .padding(.bottom, Spacing.l)
            
            HStack(alignment: .center) {
                Text("path-shell")
                    .font(.system(size: FontSize.text))
                
                Spacer()
                
                TextField("", text: $settings.shellPath)
                    .frame(width: 150)
            }
            .padding(.bottom, Spacing.l)
            
            HStack(alignment: .center) {
                Text("path-profile")
                    .font(.system(size: FontSize.text))
                
                HintView(title: "hint-profile-title", text: "hint-profile-text")
                
                Spacer()
                
                TextField("", text: $settings.profilePath)
                    .frame(width: 150)
            }
        }
        .padding(.vertical, Spacing.m)        
    }
    
    func changeShellType(stype: ShellType) {
        let shell: Shell = Shells.filter{ $0.type == settings.shell }.first!
        settings.shellPath = shell.path
        settings.profilePath = settings.homeDir + (shell.profile ?? "")
    }
}

struct SettingsShellView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsShellView()
    }
}
