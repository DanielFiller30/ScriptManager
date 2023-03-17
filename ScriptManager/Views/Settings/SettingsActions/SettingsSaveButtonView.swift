//
//  SettingsSaveButtonView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 10.02.23.
//

import SwiftUI

struct SettingsSaveButtonView: View {
    @EnvironmentObject var settings: ScriptManagerSettings

    var body: some View {
        Button {
            settings.save()
        } label: {
            HStack(alignment: .center) {
                Spacer()
                
                Text("settings-save")
                    .padding(.trailing, Spacing.m)
                    .foregroundColor(.white)
                
                Spacer()
                
                Image(systemName: "checkmark")
                    .resizable()
                    .frame(width: IconSize.s, height: IconSize.s)
                    .foregroundColor(Color.white)
            }
            .padding(Spacing.l)
            .background(AppColor.Success)
            .clipShape(RoundedRectangle(cornerRadius: 10.0))
            
        }
        .frame(width: 230)
        .disabled(
            settings.shellPath.isEmpty
            || settings.unicode.isEmpty
            || (settings.loggingState && settings.logsPath.isEmpty)
        )
        .buttonStyle(.plain)
        .padding(.bottom, Spacing.xl)
    }
}

struct SettingsSaveButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsSaveButtonView()
    }
}
