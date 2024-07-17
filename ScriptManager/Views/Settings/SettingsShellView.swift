//
//  SettingsShellView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 10.02.23.
//

import SwiftUI

struct SettingsShellView: View {
    @Binding var vm: SettingsViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack(alignment: .center) {
                Text("shell-type")
                    .font(.system(size: FontSize.text))
                
                HintView(title: "hint-shell-title", text: "hint-shell-text")
                
                Spacer()
                
                Picker("", selection: $vm.tempSettings.shell.type) {
                    ForEach(Shells) { shell in
                        Text(shell.type.rawValue)
                            .tag(shell.type)
                    }
                }
                .frame(width: 160)
            }
            .padding(.bottom, Spacing.l)
            
            HStack(alignment: .center) {
                Text("path-shell")
                    .font(.system(size: FontSize.text))
                
                Spacer()
                
                TextField("", text: $vm.tempSettings.shell.path)
                    .frame(width: 150)
            }
            .padding(.bottom, Spacing.l)
            
            HStack(alignment: .center) {
                Text("path-profile")
                    .font(.system(size: FontSize.text))
                
                HintView(title: "hint-profile-title", text: "hint-profile-text")
                
                Spacer()
                
                TextField("", text: $vm.tempProfilePath)
                    .frame(width: 150)
            }
        }
        .padding(.vertical, Spacing.m)        
    }
}

struct SettingsShellView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsShellView(vm: .constant(SettingsViewModel()))
    }
}
