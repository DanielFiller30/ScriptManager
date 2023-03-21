//
//  SettingsView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 06.02.23.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var settings: SettingsHandler
    
    @State private var toggleShell = false
    @State private var toggleShortcuts = false
    
    var body: some View {
        VStack(alignment: .center) {
            Text("settings")
                .font(.system(size: FontSize.subTitle))
                .padding(.bottom, Spacing.l)
                .padding(.top, Spacing.xl)
            
            Divider()
            
            GroupView(
                toggleVar: $toggleShell,
                toggle: { toggleShell.toggle() },
                label: "settings-shell",
                info: nil,
                padding: Spacing.zero,
                animation: false
            ) {
                SettingsShellView()
                                
                SettingsUnicodeView()
            }
            
            Divider()
            
            GroupView(
                toggleVar: $toggleShortcuts,
                toggle: { toggleShortcuts.toggle() },
                label: "settings-shortcut",
                info: nil,
                padding: Spacing.zero,
                animation: false
            ) {
                SettingsShortcutView()
            }
            
            Divider()
            
            Group {
                SettingsLoggingView()
                
                Divider()
                
                SettingsNotificationsView()
                
                Divider()
                
                SettingsAutostartView()
                
                Divider()
                
                SettingsColorView()
            }
            
            Divider()
            
            Group {
                SettingsDeleteButtonView()
                
                SettingsSaveButtonView()
            }
        }
        .frame(minWidth: 320)
        .onAppear() {
            settings.loadSettings()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
