//
//  SettingsUnicodeView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 10.02.23.
//

import SwiftUI

struct SettingsUnicodeView: View {
    @StateObject var viewModel: SettingsViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                Text("shell-unicode")
                    .font(.system(size: FontSize.text))
                
                Spacer()
                
                TextField("", text: $viewModel.unicode)
                    .frame(width: 100)
            }
        }
        .padding(.vertical, Spacing.m)
        .padding(.horizontal, Spacing.xl)    }
}

struct SettingsUnicodeView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsUnicodeView(viewModel: SettingsViewModel())
    }
}
