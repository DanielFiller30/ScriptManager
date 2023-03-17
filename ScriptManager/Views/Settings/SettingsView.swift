//
//  SettingsView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 06.02.23.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var settings: ScriptManagerSettings
    
    var body: some View {
        VStack(alignment: .center) {
            Text("settings")
                .font(.system(size: FontSize.subTitle))
                .padding(.bottom, Spacing.l)
                .padding(.top, Spacing.xl)
            
            Divider()
            
            Group {
                Group {
                    SettingsShellView()
                    
                    Divider()
                    
                    SettingsUnicodeView()
                    
                    Divider()
                    
                    Group {
                        SettingsLoggingView()
                        
                        Divider()
                        
                        SettingsNotificationsView()
                        
                        Divider()
                    }
                    
                    SettingsAutostartView()
                    
                    Divider()
                    
                    SettingsColorView()
                    
                    Divider()
                }                
                
                Group {
                    SettingsDeleteButtonView()
                    
                    SettingsSaveButtonView()
                }
            }
            
        }
        .frame(minWidth: 260)
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
