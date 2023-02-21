//
//  ScriptStateButtonView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 10.02.23.
//

import SwiftUI

struct ScriptStateButtonView: View {
    let viewModel: ScriptsViewModel
    
    @Binding var script: Script
    @Binding var isRunning: Bool
    
    var body: some View {
        if (script.finished) {
            let success = script.success == ResultState.successfull
            
            if (success) {
                // Script run successfull
                Image(systemName: "checkmark")
                    .foregroundColor(Color.Success)
                    .frame(width: IconSize.s, height: IconSize.s)
                    .padding(Spacing.l)
                    .background(Color.Background)
                    .clipShape(Circle())
            } else if (viewModel.isLogEnabled) {
                // Script failed and logging is active
                Button {
                    viewModel.openLogs()
                } label: {
                    Image(systemName: "xmark")
                        .resizable()
                        .frame(width: IconSize.s, height: IconSize.s)
                        .padding(Spacing.l)
                        .foregroundColor(Color.Creme)
                        .background(Color.Danger)
                        .clipShape(Circle())
                }
                .buttonStyle(.plain)
                .disabled(isRunning)
            } else {
                // Script failed but logging is disabled
                Image(systemName: "xmark")
                    .foregroundColor(Color.Danger)
                    .frame(width: IconSize.s, height: IconSize.s)
                    .padding(Spacing.l)
                    .background(Color.Background)
                    .clipShape(Circle())
            }
            
        }
    }
}

struct ScriptStateButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ScriptStateButtonView(viewModel: ScriptsViewModel(), script: .constant(DefaultScript), isRunning: .constant(false))
    }
}
