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
                .fontWeight(.bold)
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
                // Save settings
                CustomButtonView(
                    onClick: { settings.saveSettings() },
                    label: "settings-save",
                    color: AppColor.Success,
                    outlined: false,
                    disabled: settings.shellPath.isEmpty
                    || settings.unicode.isEmpty
                    || (settings.loggingState && settings.logsPath.isEmpty)
                )
                .padding(.bottom, Spacing.m)
                .padding(.top, Spacing.l)
        
                // Remove scripts
                CustomButtonView(
                    onClick: { settings.showDeleteAlert.toggle() },
                    label: "settings-reset",
                    color: AppColor.Creme,
                    outlined: true,
                    disabled: false
                )
                .padding(.bottom, Spacing.m)
                .alert("settings-delete-title", isPresented: $settings.showDeleteAlert) {
                    
                    Button("cancel", role: .cancel) {}
                    Button("delete") {
                        settings.reset()
                    }
                    
                } message: {
                    Text("settings-delete-msg")
                }
                
                // Cancel
                CustomButtonView(
                    onClick: { settings.showingPopover.toggle() },
                    label: "cancel",
                    color: AppColor.Creme,
                    outlined: true,
                    disabled: false
                )
                .padding(.bottom, Spacing.xl)

            }
            .padding(.horizontal, Spacing.xl)

        }
        .frame(minWidth: 320)
        .background(AppColor.AppBg)
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
