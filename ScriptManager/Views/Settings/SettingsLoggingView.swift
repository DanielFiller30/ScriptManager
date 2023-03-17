//
//  SettingsLoggingView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 10.02.23.
//

import SwiftUI

struct SettingsLoggingView: View {
    @EnvironmentObject var settings: ScriptManagerSettings
    
    var body: some View {
        VStack(alignment: .center) {
            HStack(alignment: .center) {
                Text("settings-logging")
                    .font(.system(size: FontSize.text))
                
                Spacer()
                
                Toggle("", isOn: $settings.loggingState)
                    .toggleStyle(.switch)
            }
            
            HStack(alignment: .center) {
                Text("path-logs")
                    .font(.system(size: FontSize.text))
                
                Spacer()
                
                TextField("", text: $settings.logsPath)
                    .frame(width: 100)
            }
        }
        .padding(.vertical, Spacing.m)
        .padding(.horizontal, Spacing.xl)
    }
}

struct SettingsLoggingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsLoggingView()
    }
}
