//
//  ScriptRunButtonView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 10.02.23.
//

import SwiftUI

struct ScriptRunButtonView: View {
    let viewModel: ScriptsViewModel
    let reloadSettings: () -> Void
    
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
                .background(Color.Background)
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
                    .background(Color.Background)
                    .clipShape(Circle())
            }
            .buttonStyle(.plain)
            .disabled(isRunning)
        }
    }
    
    func runScript() async {
        activeId = script.id
        isRunning = true
        
        script.success = await scriptHandler.runScript(script.path, scriptName: script.name, test: false)
        script.finished = true
        script.lastRun = Date.now
        viewModel.updateScripts()
        
        isRunning = false
        reloadSettings()
    }
}

struct ScriptRunButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ScriptRunButtonView(viewModel: ScriptsViewModel(), reloadSettings: {}, script: .constant(DefaultScript), isRunning: .constant(false))
    }
}
