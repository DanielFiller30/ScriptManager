//
//  SettingsView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 06.02.23.
//

import SwiftUI

struct SettingsModalView: View {
    @State private var toggleShell = false
    @State private var toggleShortcuts = false
    
    @State private var vm = SettingsViewModel()
    
    var body: some View {
        VStack(alignment: .center) {
            ScrollView {
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
            }
            
            Divider()
            
            Group {
                // Save settings
                CustomButtonView(
                    onClick: { vm.saveSettings() },
                    label: "settings-save",
                    color: AnyShapeStyle(AppColor.Success),
                    outlined: false,
                    disabled: vm.settingsHandler.settings.shell.path.isEmpty
                    || vm.settingsHandler.settings.unicode.isEmpty
                    || (vm.settingsHandler.settings.logs && vm.settingsHandler.settings.pathLogs.isEmpty)
                )
                .padding(.bottom, Spacing.m)
                .padding(.top, Spacing.l)
        
//                // Remove scripts
//                CustomButtonView(
//                    onClick: { vm.showResetAlert() },
//                    label: "settings-reset",
//                    color: AppColor.Creme,
//                    outlined: true,
//                    disabled: false
//                )
//                .padding(.bottom, Spacing.m)
                
                // Cancel
                CustomButtonView(
                    onClick: { vm.modalHandler.hideModal() },
                    label: "cancel",
                    color: AnyShapeStyle(.ultraThickMaterial),
                    outlined: true,
                    disabled: false
                )
                
                CustomButtonView(
                    onClick: {
                        vm.modalHandler.hideModal()
                        vm.showCloseAlert()
                    },
                    label: "close-app-title",
                    color: AnyShapeStyle(.ultraThickMaterial),
                    outlined: true,
                    disabled: false
                )
                .padding(.bottom, Spacing.xl)

            }
            .padding(.horizontal, Spacing.xl)

        }
    }
}

struct SettingsModalView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsModalView()
    }
}
