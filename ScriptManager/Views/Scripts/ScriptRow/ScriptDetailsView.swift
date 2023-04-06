//
//  ScriptDetailsView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 05.02.23.
//

import SwiftUI
import AlertToast

struct ScriptDetailsView: View {
    var viewModel: ScriptViewModel
    let scriptHandler: ScriptHandler = ScriptHandler()
    var script: Script
    
    var isRunning: Bool
    @State private var showToast = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                Text("path")
                    .font(.system(size: FontSize.text))
                    .fontWeight(.bold)
                    .frame(width: 80, alignment: .leading)
                
                Spacer()
                
                Text(script.command)
                    .font(.system(size: FontSize.text))
                    .onTapGesture() {
                        // Copy path
                        let pasteboard = NSPasteboard.general
                        pasteboard.clearContents()
                        pasteboard.setString(script.command, forType: .string)
                        
                        // Show copied toast
                        showToast.toggle()
                    }
            }
            .padding(.bottom, Spacing.m)
            .toast(isPresenting: $showToast, duration: 1, tapToDismiss: true) {
                AlertToast(type: .regular, title: "hint-copied")
            }
            
            HStack(alignment: .top) {
                Text("last-run")
                    .font(.system(size: FontSize.text))
                    .fontWeight(.bold)
                    .frame(width: 80, alignment: .leading)
                
                Spacer()
                
                if (script.lastRun != nil) {
                    Text(DateHandler.getFormattedDate(date: script.lastRun!))
                        .font(.system(size: FontSize.text))
                } else {
                    Text("-")
                        .font(.system(size: FontSize.text))
                }
            }
            
            Divider()
            
            HStack(alignment: .center) {
                // Open logs
                ScriptDetailButtonView(
                    onClick: { viewModel.openLogs() },
                    icon: "folder",
                    disabled: false,
                    help: "button-logs"
                )
                                
                Spacer()
                
                // Edit script
                ScriptDetailButtonView(
                    onClick: { viewModel.openEdit(script: script) },
                    icon: "pencil",
                    disabled: isRunning,
                    help: "button-edit"
                )
                
                // Delete script
                ScriptDeleteButtonView(viewModel: viewModel, scriptId: script.id, isRunning: isRunning)
            }
            .padding(.all, Spacing.m)
        }
        .padding(.all, Spacing.m)
    }
}

struct ScriptDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ScriptDetailsView(viewModel: ScriptViewModel(), script: DefaultScript, isRunning: false)
    }
}
