//
//  ScriptRunButtonView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 10.02.23.
//

import SwiftUI

struct ScriptRunButtonView: View {
    let viewModel: ScriptViewModel
    let scriptHandler: ScriptHandler = ScriptHandler()
    
    @Binding var script: Script
    @Binding var isRunning: Bool
    
    @State var activeId: UUID? = nil
    
    var body: some View {
        if (isRunning && activeId == script.id) {
            ProgressView()
                .frame(width: IconSize.s, height: IconSize.s)
                .scaleEffect(0.5)
                .padding(Spacing.l)
                .background(AppColor.Background)
                .clipShape(Circle())
            
        } else {
            Button {
                Task {
                    await runScript()
                }
            } label: {
                Image(systemName: "play")
                    .resizable()
                    .frame(width: IconSize.s, height: IconSize.s)
                    .padding(Spacing.l)
                    .background(AppColor.Background)
                    .clipShape(Circle())
            }
            .buttonStyle(.plain)
            .disabled(isRunning)
        }
    }
    
    func runScript() async {
        activeId = script.id
        isRunning = true
        
        script.success = await scriptHandler.runScript(script, test: false)
        script.finished = true
        script.lastRun = Date.now
        
        viewModel.refreshScripts()
        
        isRunning = false
        
        viewModel.loadSettings()
    }
}

struct ScriptRunButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ScriptRunButtonView(viewModel: ScriptViewModel(), script: .constant(DefaultScript), isRunning: .constant(false))
    }
}
