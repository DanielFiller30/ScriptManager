//
//  SettingsDeleteButtonView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 10.02.23.
//

import SwiftUI

struct SettingsDeleteButtonView: View {
    @EnvironmentObject var settings: SettingsHandler

    var body: some View {
        Button {
            settings.showDeleteAlert.toggle()
        } label: {
            HStack(alignment: .center) {
                Spacer()
                
                Text("settings-reset")
                    .padding(.trailing, Spacing.m)
                
                Spacer()
                
                Image(systemName: "trash")
                    .resizable()
                    .frame(width: IconSize.m, height: IconSize.m)
                    .foregroundColor(AppColor.Creme)
            }
            .padding(Spacing.l)
            .background(AppColor.Dark)
            .clipShape(RoundedRectangle(cornerRadius: 10.0))
            
        }
        .frame(width: 230)
        .buttonStyle(.plain)
        .padding(.top, Spacing.l)
        .alert("settings-delete-title", isPresented: $settings.showDeleteAlert) {
            
            Button("cancel", role: .cancel) {}
            Button("delete") {
                settings.reset()
            }
            
        } message: {
            Text("settings-delete-msg")
        }
        
    }
}

struct SettingsDeleteButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsDeleteButtonView()
    }
}
