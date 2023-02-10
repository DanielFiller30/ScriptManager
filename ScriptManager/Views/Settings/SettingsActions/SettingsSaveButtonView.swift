//
//  SettingsSaveButtonView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 10.02.23.
//

import SwiftUI

struct SettingsSaveButtonView: View {
    @StateObject var viewModel: SettingsViewModel

    var body: some View {
        Button {
            viewModel.save()
        } label: {
            HStack(alignment: .center) {
                Text("settings-save")
                    .padding(.trailing, Spacing.m)
                
                Spacer()
                
                Image(systemName: "checkmark")
                    .resizable()
                    .frame(width: IconSize.s, height: IconSize.s)
                    .foregroundColor(Color.Success)
            }
            .padding(Spacing.l)
            .background(Color.Light)
            .clipShape(RoundedRectangle(cornerRadius: 10.0))
            
        }
        .frame(width: 220)
        .disabled(viewModel.shellPath.isEmpty || viewModel.unicode.isEmpty)
        .buttonStyle(.plain)
        .padding(.bottom, Spacing.xl)    }
}

struct SettingsSaveButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsSaveButtonView(viewModel: SettingsViewModel())
    }
}
