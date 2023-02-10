//
//  SettingsView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 06.02.23.
//

import SwiftUI

struct SettingsView: View {
    @StateObject var viewModel: SettingsViewModel
    
    var body: some View {
        VStack(alignment: .center) {
            Text("settings")
                .font(.system(size: Font.subTitle))
                .padding(.bottom, Spacing.l)
                .padding(.top, Spacing.xl)
            
            Divider()
            
            Group {
                SettingsShellView(viewModel: viewModel)
                
                Divider()
                
                SettingsUnicodeView(viewModel: viewModel)
                
                Divider()
                
                SettingsLoggingView(viewModel: viewModel)
                
                Divider()
                
                SettingsNotificationsView(viewModel: viewModel)
                
                Divider()
                
                SettingsDeleteButtonView(viewModel: viewModel)
                
                SettingsSaveButtonView(viewModel: viewModel)
            }
            
        }
        .frame(minWidth: 250)
        .onAppear() {
            viewModel.loadSettings()
        }
    }
    
}