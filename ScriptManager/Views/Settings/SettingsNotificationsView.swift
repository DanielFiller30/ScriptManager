//
//  SettingsNotificationsView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 10.02.23.
//

import SwiftUI

struct SettingsNotificationsView: View {
    @EnvironmentObject var settings: SettingsHandler
    
    var body: some View {
        VStack(alignment: .center) {
            HStack(alignment: .center) {
                Text("settings-notifications")
                    .font(.system(size: FontSize.text))
                
                HintView(title: "hint-notifications-title", text: "hint-notifications-text")
                
                Spacer()
                
                Toggle("", isOn: $settings.notificationState)
                    .toggleStyle(.switch)
                    .onChange(of: settings.notificationState) { state in
                        settings.activateNotifications()
                    }
                
            }
        }
        .padding(.vertical, Spacing.m)
        .padding(.horizontal, Spacing.xl)
    }
}

struct SettingsNotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsNotificationsView()
    }
}
