//
//  AddScriptView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 03.02.23.
//

import SwiftUI

struct AddScriptView: View {
    @StateObject var viewModel: ScriptsViewModel
    
    @State var testIsRunning: Bool = false
    @State var testResult: String = ""
    @State var testIsSuccessfull: ResultState = .ready
    var closeGroup: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            
            VStack(alignment: .leading) {
                Text("name-add-script")
                    .font(.system(size: 11))
                
                TextField("", text: $viewModel.name)
                
            }
            .padding(.bottom, Spacing.l)
            
            VStack(alignment: .leading) {
                Text("path-add-script")
                    .font(.system(size: 11))
                
                TextField("cd /Desktop/ sh ...", text: $viewModel.path, axis: .vertical)
                    .lineLimit(4, reservesSpace: true)
                
            }.padding(.bottom, Spacing.l)
            
            HStack(alignment: .center) {
                Button {
                    Task {
                        testIsRunning = true
                        testIsSuccessfull = await viewModel.runScript(viewModel.path)
                        testResult = testIsSuccessfull == .successfull ? String(localized: "test-success") : String(localized: "test-failed")
                        testIsRunning = false
                    }
                } label: {
                    HStack(alignment: .center) {
                        Text("test-script")
                            .padding(.trailing, Spacing.m)
                        
                        if (!testIsRunning) {
                            Image(systemName: "play")
                                .resizable()
                                .frame(width: 13, height: 13)
                                .foregroundColor(Color.Creme)
                            
                        } else {
                            ProgressView()
                                .frame(width: 10, height: 10)
                                .scaleEffect(0.5)
                                .progressViewStyle(.circular)
                        }
                        
                    }
                    .padding(Spacing.l)
                    .background(Color.Dark)
                    .clipShape(RoundedRectangle(cornerRadius: 10.0))
                    
                }
                .buttonStyle(.plain)
                .disabled(testIsRunning || viewModel.path.isEmpty)
                
                Spacer()
                
                Button {
                    viewModel.saveScript()
                    closeGroup()
                } label: {
                    HStack(alignment: .center) {
                        Text("save-script")
                            .padding(.trailing, Spacing.m)
                        
                        Image(systemName: "doc.badge.plus")
                            .resizable()
                            .frame(width: 15, height: 15)
                            .foregroundColor(Color.Creme)
                    }
                    .padding(Spacing.l)
                    .background(Color.Success)
                    .clipShape(RoundedRectangle(cornerRadius: 10.0))
                    
                }
                .buttonStyle(.plain)
                .disabled(testIsRunning || viewModel.name.isEmpty || viewModel.path.isEmpty)
            }
            
            Text(testResult)
                .font(.system(size: 12))
                .foregroundColor(testIsSuccessfull == .successfull ? Color.Success : Color.Danger)
                .padding(.top, Spacing.m)
            
        }
    }
}
