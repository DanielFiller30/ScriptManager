//
//  SettingsAutostartView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 17.03.23.
//

import SwiftUI
import LaunchAtLogin

struct SettingsAutostartView: View {
    var body: some View {
        VStack(alignment: .center) {
            HStack(alignment: .center) {
                Text("settings-autostart")
                    .font(.system(size: FontSize.text))
                                
                Spacer()
                                
                LaunchAtLogin.Toggle("")
                    .toggleStyle(.switch)
            }
        }
        .padding(.vertical, Spacing.m)
        .padding(.horizontal, Spacing.xl)
    }
}

struct SettingsAutostartView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsAutostartView()
    }
}
