//
//  ScriptDetailsView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 05.02.23.
//

import Resolver
import SwiftUI
import AlertToast

struct ScriptDetailsView: View {
    @State private var vm = ScriptViewModel()
    
    @Binding var showAddScriptModal: Bool
    
    var script: Script
    
    @State private var showToast = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                Text("path")
                    .font(.caption)
                    .fontWeight(.bold)
                    .frame(width: 120, alignment: .leading)
                
                Spacer()
                
                Text(script.command)
                    .font(.caption)
                    .lineLimit(1)
                    .onTapGesture() {
                        // Copy path
                        let pasteboard = NSPasteboard.general
                        pasteboard.clearContents()
                        pasteboard.setString(script.command, forType: .string)
                        
                        // Show 'copied' toast
                        showToast.toggle()
                    }
                    .help(script.command)
            }
            .padding(.bottom, Spacing.l)
            .toast(isPresenting: $showToast, duration: 1, tapToDismiss: true) {
                AlertToast(type: .regular, title: String(localized: "hint-copied"))
            }
            
            HStack(alignment: .center) {
                Text("shortcut-title")
                    .font(.caption)
                    .fontWeight(.bold)
                    .frame(width: 120, alignment: .leading)
                
                Spacer()
                
                if let shortcut = vm.getMatchingShortcut(script.id) {
                    ShortcutView(shortcut: shortcut)
                } else {
                    Text("-")
                        .font(.caption)
                }
            }
            .padding(.bottom, Spacing.l)
            
            HStack(alignment: .center) {
                Text("last-run")
                    .font(.caption)
                    .fontWeight(.bold)
                    .frame(width: 120, alignment: .leading)
                
                Spacer()
                
                if let date = script.lastRun {
                    Text(date.toFormattedDate())
                        .font(.caption)
                } else {
                    Text("-")
                        .font(.caption)
                }
            }
            .padding(.bottom, Spacing.l)
            
            Divider()
                .foregroundStyle(.white)
                .padding(.bottom, Spacing.m)
            
            HStack(alignment: .center) {
                // Open logs
                ScriptDetailButtonView(
                    onClick: { vm.openLogs() },
                    icon: "folder",
                    disabled: false,
                    help: "button-logs"
                )
                
                Spacer()
                
                // Open monitor
                ScriptDetailButtonView(
                    onClick: {
                        vm.openOutputWindow(script: script)
                    },
                    icon: "play.tv",
                    disabled: false,
                    help: "button-monitor"
                )
                
                // Interrupt script
                ScriptDetailButtonView(
                    onClick: {
                        debugPrint("Interrupt script")
                        vm.scriptHandler.interruptRunningProcess(scriptId: script.id)
                    },
                    icon: "stop.fill",
                    disabled: vm.scriptHandler.runningScript.count == 0 || !vm.scriptHandler.runningScript.contains(where: { $0.id == script.id }),
                    help: "button-interrupt"
                )
                
                // Edit script
                ScriptDetailButtonView(
                    onClick: {
                        vm.openEdit(script: script)                        
                    },
                    icon: "pencil",
                    disabled: vm.scriptHandler.runningScript.contains(where: { $0.id == script.id }),
                    help: "button-edit"
                )
                
                // Delete script
                ScriptDeleteButtonView(
                    scriptId: script.id,
                    disabled: vm.scriptHandler.runningScript.contains(where: { $0.id == script.id })
                )
            }
        }
    }
}

struct ScriptDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ScriptDetailsView(showAddScriptModal: .constant(false), script: DefaultScript)
    }
}
