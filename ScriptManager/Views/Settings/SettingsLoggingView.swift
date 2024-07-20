//
//  SettingsLoggingView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 10.02.23.
//

import SwiftUI

struct SettingsLoggingView: View {
    @Binding var vm: SettingsViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                Text("settings-logging")
                    .font(.system(size: FontSize.text))
                
                Spacer()
                
                Toggle("", isOn: $vm.tempSettings.logs)
                    .toggleStyle(.switch)
            }
            
            Text("path-logs")
                .font(.system(size: FontSize.text))
            
            HStack(alignment: .center) {
                TextField("", text: $vm.tempSettings.pathLogs)
                    .textFieldStyle(.roundedBorder)
                
                Button {
                    vm.openLoggingDirectory()
                } label: {
                    Image(systemName: "folder")
                        .padding(Spacing.m)
                        .background(.ultraThickMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.vertical, Spacing.m)
        .padding(.horizontal, Spacing.xl)
    }
}

struct SettingsLoggingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsLoggingView(vm: .constant(SettingsViewModel()))
    }
}
