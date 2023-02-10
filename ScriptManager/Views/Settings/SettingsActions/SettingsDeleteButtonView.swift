//
//  SettingsDeleteButtonView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 10.02.23.
//

import SwiftUI

struct SettingsDeleteButtonView: View {
    @StateObject var viewModel: SettingsViewModel
    
    var body: some View {
        Button {
            viewModel.showDeleteAlert.toggle()
        } label: {
            HStack(alignment: .center) {
                Text("settings-reset")
                    .padding(.trailing, Spacing.m)
                
                Spacer()
                
                Image(systemName: "trash")
                    .resizable()
                    .frame(width: IconSize.m, height: IconSize.m)
                    .foregroundColor(Color.Creme)
            }
            .padding(Spacing.l)
            .background(Color.Dark)
            .clipShape(RoundedRectangle(cornerRadius: 10.0))
            
        }
        .frame(width: 220)
        .buttonStyle(.plain)
        .padding(.top, Spacing.l)
        .alert(String(localized: "settings-delete-title"), isPresented: $viewModel.showDeleteAlert) {
            
            Button("cancel", role: .cancel) {}
            Button("delete") {
                viewModel.reset()
            }
            
        } message: {
            Text("settings-delete-msg")
        }
        
    }
}

struct SettingsDeleteButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsDeleteButtonView(viewModel: SettingsViewModel())
    }
}
