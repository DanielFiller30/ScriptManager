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
    @State private var toggleBackup = false
    @State private var toggleLogging = false

    @State private var vm = SettingsViewModel()
    
    var body: some View {
        VStack(alignment: .center) {
            ScrollView {
                Group {
                    SettingsNotificationsView(vm: $vm)
                    
                    Divider()
                    
                    SettingsAutostartView()
                }
                
                Divider()
                
                GroupView(
                    toggleVar: $toggleShell,
                    toggle: { toggleShell.toggle() },
                    label: "settings-shell",
                    info: nil,
                    padding: Spacing.zero,
                    animation: false
                ) {
                    SettingsShellView(vm: $vm)
                    
                    SettingsUnicodeView(vm: $vm)
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
                    SettingsShortcutView(vm: $vm)
                }
                
                Divider()
                
                GroupView(
                    toggleVar: $toggleLogging,
                    toggle: { toggleLogging.toggle() },
                    label: "logging",
                    info: nil,
                    padding: Spacing.zero,
                    animation: false
                ) {
                    SettingsLoggingView(vm: $vm)
                }
                
                Divider()
                
                GroupView(
                    toggleVar: $toggleBackup,
                    toggle: { toggleBackup.toggle() },
                    label: "backup",
                    info: nil,
                    padding: Spacing.zero,
                    animation: false
                ) {
                    SettingsBackupView()
                }
            }
            
            Divider()
            
            Group {
                // Save settings
                CustomButtonView(
                    onClick: { vm.saveSettings() },
                    label: "settings-save",
                    color: AnyShapeStyle(AppColor.Primary),
                    outlined: false,
                    disabled: vm.tempSettings.shell.path.isEmpty
                    || vm.tempSettings.unicode.isEmpty
                    || (vm.tempSettings.logs && vm.tempSettings.pathLogs.isEmpty)
                )
                .padding(.bottom, Spacing.m)
                .padding(.top, Spacing.l)
                
                // Cancel
                CustomButtonView(
                    onClick: { vm.modalHandler.hideModal() },
                    label: "cancel",
                    color: AnyShapeStyle(.ultraThickMaterial),
                    outlined: true,
                    disabled: false
                )
                
                HStack {
                    CustomButtonView(
                        onClick: {
                            vm.modalHandler.hideModal()
                            vm.modalHandler.showModal(.INFO)
                        },
                        label: "info-title",
                        color: AnyShapeStyle(.ultraThickMaterial),
                        outlined: true,
                        disabled: false
                    )
                    .padding(.bottom, Spacing.xl)
                    
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
