//
//  ScriptStateButtonView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 10.02.23.
//

import SwiftUI

struct ScriptStateButtonView: View {
    let viewModel: ScriptViewModel
    var script: Script
    
    var body: some View {
        if (script.finished) {
            let success = script.success == ResultState.successfull
            
            if (success) {
                // Script run successfull
                Image(systemName: "checkmark")
                    .foregroundColor(AppColor.Success)
                    .frame(width: IconSize.s, height: IconSize.s)
                    .padding(Spacing.l)
                    .background(AppColor.Light)
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
                        .foregroundColor(AppColor.Creme)
                        .background(AppColor.Danger)
                        .clipShape(Circle())
                }
                .buttonStyle(.plain)
                .disabled(viewModel.isRunning && viewModel.runningScript.contains(where: { $0.id == script.id }))
            } else {
                // Script failed but logging is disabled
                Image(systemName: "xmark")
                    .foregroundColor(AppColor.Danger)
                    .frame(width: IconSize.s, height: IconSize.s)
                    .padding(Spacing.l)
                    .background(AppColor.Light)
                    .clipShape(Circle())
            }
            
        }
    }
}

struct ScriptStateButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ScriptStateButtonView(viewModel: ScriptViewModel(), script: DefaultScript)
    }
}
