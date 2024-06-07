//
//  SettingsNotificationsView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 10.02.23.
//

import SwiftUI

struct SettingsNotificationsView: View {
    @State private var vm = SettingsViewModel()

    var body: some View {
        VStack(alignment: .center) {
            HStack(alignment: .center) {
                Text("settings-notifications")
                    .font(.system(size: FontSize.text))
                
                HintView(title: "hint-notifications-title", text: "hint-notifications-text")
                
                Spacer()
                
                Toggle("", isOn: $vm.settingsHandler.settings.notifications)
                    .toggleStyle(.switch)
                    .onChange(of: vm.settingsHandler.settings.notifications) { _,_ in
                        vm.activateNotifications()
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
