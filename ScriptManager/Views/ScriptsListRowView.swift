//
//  ScriptsListRowView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 05.02.23.
//

import SwiftUI

struct ScriptsListRowView: View {
    @StateObject var viewModel: ScriptsViewModel

    @State var isRunning: Bool = false
    @State var activeId: UUID? = nil
    @State var script: Script
    @State var showDetails: Bool = false
    
    var body: some View {
        HStack(alignment: .center) {        
            Text(script.name)
                .foregroundColor(.white)
                .font(.system(size: 10))
            
            Text(script.path)
                .foregroundColor(.Creme)
                .font(.system(size: 10))
                .frame(maxWidth: 100)
                .lineLimit(1)
            
            Spacer()
            
            if (script.lastRun != nil) {
                Text(viewModel.getFormattedDate(date: script.lastRun!))
                    .foregroundColor(.Creme)
                    .font(.system(size: 10))
                    .frame(maxWidth: 50)
                    .lineLimit(2)
            }
            
            if (script.finished) {
                let success = script.success == ResultState.successfull
                Image(systemName: success ? "checkmark" : "error")
                    .foregroundColor(success ? Color.Success : Color.Danger)
                    .frame(width: 20, height: 20)
                    .padding(Spacing.m)
                    .background(Color.Background)
                    .clipShape(Circle())
            }
            
            if (isRunning && activeId == script.id) {
                ProgressView()
                    .frame(width: 13, height: 13)
                    .scaleEffect(0.5)
            } else {
                Button {
                    Task {
                        activeId = script.id
                        isRunning = true
                        
                        script.success = await viewModel.runScript(script.path)
                        script.finished = true
                        script.lastRun = Date.now
                        viewModel.updateScripts()
                        
                        isRunning = false
                    }
                } label: {
                    Image(systemName: "play")
                        .resizable()
                        .frame(width: 13, height: 13)
                }
                .buttonStyle(.plain)
                .frame(width: 20, height: 20)
                .padding(Spacing.m)
                .background(Color.Background)
                .clipShape(Circle())
                .disabled(isRunning)
            }
            
        }
        .padding()
        .frame(height: 60)
        .frame(maxWidth: 350, alignment: .leading)
        .background(Color.Dark)
        .cornerRadius(10)
    }
}
