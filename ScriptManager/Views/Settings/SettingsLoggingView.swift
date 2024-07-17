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
        VStack(alignment: .center) {
            HStack(alignment: .center) {
                Text("settings-logging")
                    .font(.system(size: FontSize.text))
                
                Spacer()
                
                Toggle("", isOn: $vm.tempSettings.logs)
                    .toggleStyle(.switch)
            }
            
            HStack(alignment: .center) {
                Text("path-logs")
                    .font(.system(size: FontSize.text))
                
                Spacer()
                
                TextField("", text: $vm.tempSettings.pathLogs)
                    .frame(width: 150)
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
