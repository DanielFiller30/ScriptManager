//
//  SettingsColorView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 17.03.23.
//

import SwiftUI

struct SettingsColorView: View {
    @EnvironmentObject var settings: ScriptManagerSettings

    var body: some View {
        VStack(alignment: .center) {
            HStack(alignment: .center) {
                Text("settings-color")
                    .font(.system(size: FontSize.text))
                                
                Spacer()
                
                ColorPicker("", selection: $settings.mainColor)                
            }
        }
        .padding(.vertical, Spacing.m)
        .padding(.horizontal, Spacing.xl)    }
}

struct SettingsColorView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsColorView()
    }
}
