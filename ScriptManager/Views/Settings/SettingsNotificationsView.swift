//
//  SettingsNotificationsView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 10.02.23.
//

import SwiftUI

struct SettingsNotificationsView: View {
    @StateObject var viewModel: SettingsViewModel

    var body: some View {
        VStack(alignment: .center) {
            HStack(alignment: .center) {
                Text("settings-notifications")
                    .font(.system(size: FontSize.text))

                HintView(title: "hint-notifications-title", text: "hint-notifications-text")

                Spacer()
                
                Toggle("", isOn: $viewModel.notificationState)
                    .toggleStyle(.switch)
                    .onChange(of: viewModel.notificationState) { state in
                        viewModel.activateNotifications()
                    }
                    
            }
        }
        .padding(.vertical, Spacing.m)
        .padding(.horizontal, Spacing.xl)    }
}

struct SettingsNotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsNotificationsView(viewModel: SettingsViewModel())
    }
}
