//
//  SettingsView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 06.02.23.
//

import SwiftUI

struct SettingsView: View {
    @StateObject var viewModel: SettingsViewModel
    
    var body: some View {
        VStack(alignment: .center) {
            Text("settings")
                .font(.headline)
                .padding(.bottom, Spacing.l)
                .padding(.top, Spacing.xl)
            
            Divider()
            
            VStack(alignment: .leading) {
                
                HStack(alignment: .center) {
                    Text("shell-type")
                        .font(.system(size: 11))
                    
                    Spacer()
                    
                    Picker("", selection: $viewModel.shell) {
                        ForEach(Shells) { shell in
                            Text(shell.type.rawValue)
                                .tag(shell.type)
                        }
                    }
                    .onChange(of: viewModel.shell) { _ in
                        let shell: Shell = Shells.filter{ $0.type == viewModel.shell }.first!
                        viewModel.shellPath = shell.path
                        viewModel.profilePath = viewModel.homeDir + (shell.profile ?? "")
                    }
                    .frame(width: 110)
                }
                .padding(.bottom, Spacing.l)
                
                HStack(alignment: .center) {
                    Text("path-shell")
                        .font(.system(size: 11))
                    
                    Spacer()
                    
                    TextField("", text: $viewModel.shellPath)
                        .frame(width: 100)
                }
                .padding(.bottom, Spacing.l)
                
                HStack(alignment: .center) {
                    Text("path-profile")
                        .font(.system(size: 11))
                    
                    Spacer()
                    
                    TextField("", text: $viewModel.profilePath)
                        .frame(width: 100)
                }
            }
            .padding(.vertical, Spacing.m)
            .padding(.horizontal, Spacing.xl)
                        
            Divider()
            
            VStack(alignment: .leading) {
                HStack(alignment: .center) {
                    Text("shell-unicode")
                        .font(.system(size: 11))
                    
                    Spacer()
                    
                    TextField("", text: $viewModel.unicode)
                        .frame(width: 100)
                }
            }
            .padding(.vertical, Spacing.m)
            .padding(.horizontal, Spacing.xl)
            
            Divider()

            Button {
                viewModel.showDeleteAlert.toggle()
            } label: {
                HStack(alignment: .center) {
                    Text("settings-reset")
                        .padding(.trailing, Spacing.m)
                    
                    Spacer()
                    
                    Image(systemName: "trash")
                        .resizable()
                        .frame(width: 15, height: 15)
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
            
            Button {
                viewModel.save()
            } label: {
                HStack(alignment: .center) {
                    Text("settings-save")
                        .padding(.trailing, Spacing.m)
                    
                    Spacer()
                    
                    Image(systemName: "checkmark")
                        .resizable()
                        .frame(width: 10, height: 10)
                        .foregroundColor(Color.Success)
                }
                .padding(Spacing.l)
                .background(Color.Light)
                .clipShape(RoundedRectangle(cornerRadius: 10.0))
                
            }
            .frame(width: 220)
            .disabled(viewModel.shellPath.isEmpty || viewModel.unicode.isEmpty)
            .buttonStyle(.plain)
            .padding(.bottom, Spacing.xl)
            
        }
        .frame(minWidth: 250)
        .onAppear() {
            viewModel.loadUserDir()
        }
    }
}
