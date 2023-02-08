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
    @State var showDeleteAlert: Bool = false

    var body: some View {
        DisclosureGroup(isExpanded: $showDetails) {
            Divider()
                .padding(.top, Spacing.l)
            
            ScriptDetailsView(script: script)
        } label: {
            HStack(alignment: .center) {
                Text(script.name)
                    .foregroundColor(.white)
                    .font(.system(size: 12))
                    .fontWeight(.bold)
                    .frame(maxWidth: 110, alignment: .leading)
                    .lineLimit(1)
                    .onTapGesture {
                        withAnimation() {
                            showDetails.toggle()
                        }
                    }
                
                Spacer()
                
                if (script.finished) {
                    let success = script.success == ResultState.successfull
                    
                    if (success) {
                        Image(systemName: "checkmark")
                            .foregroundColor(success ? Color.Success : Color.Danger)
                            .frame(width: 13, height: 13)
                            .padding(Spacing.l)
                            .background(Color.Background)
                            .clipShape(Circle())
                    } else {
                        Button {
                            viewModel.openLogs()
                        } label: {
                            Image(systemName: "xmark")
                                .resizable()
                                .frame(width: 13, height: 13)
                                .padding(Spacing.l)
                                .foregroundColor(Color.Creme)
                                .background(Color.Danger)
                                .clipShape(Circle())
                        }
                        .buttonStyle(.plain)
                        .disabled(isRunning)
                    }
                    
                }
                
                if (isRunning && activeId == script.id) {
                    ProgressView()
                        .frame(width: 13, height: 13)
                        .scaleEffect(0.5)
                        .padding(.trailing, Spacing.m)
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
                            .padding(Spacing.l)
                            .background(Color.Background)
                            .clipShape(Circle())
                    }
                    .buttonStyle(.plain)
                    .disabled(isRunning)
                }
                
                Button {
                    showDeleteAlert.toggle()
                } label: {
                    Image(systemName: "trash")
                        .resizable()
                        .frame(width: 13, height: 13)
                        .padding(Spacing.l)
                        .background(Color.Background)
                        .clipShape(Circle())
                }
                .buttonStyle(.plain)
                .disabled(isRunning)
                .alert(String(localized: "delete-title"), isPresented: $showDeleteAlert) {
                   
                    Button("cancel", role: .cancel) {}
                    Button("delete") {
                        viewModel.deleteScript(id: script.id)
                    }
                   
                } message: {
                    Text("delete-msg")
                }
            }
            
        }
        .padding(.all, Spacing.l)
        .frame(maxWidth: 350, alignment: .leading)
        .background(Color.Dark)
        .cornerRadius(10)
        
        
    }
}
