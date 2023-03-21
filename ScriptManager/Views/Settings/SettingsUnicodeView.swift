//
//  SettingsUnicodeView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 10.02.23.
//

import SwiftUI

struct SettingsUnicodeView: View {
    @EnvironmentObject var settings: SettingsHandler

    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                Text("shell-unicode")
                    .font(.system(size: FontSize.text))
                
                Spacer()
                
                TextField("", text: $settings.unicode)
                    .frame(width: 150)
            }
        }
        .padding(.vertical, Spacing.m)                
    }
}

struct SettingsUnicodeView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsUnicodeView()
    }
}
