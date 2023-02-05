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
                
                TextField("", text: $viewModel.path)
                
            }.padding(.bottom, Spacing.xl)
            
            HStack(alignment: .center) {
                ZStack(alignment: .center) {
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
                            
                            if (!testIsRunning) {
                                Image(systemName: "play")
                                    .resizable()
                                    .frame(width: 13, height: 13)
                                    .foregroundColor(Color.Light)
                                
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
                    .disabled(testIsRunning)
                    
                    Text(testResult)
                        .font(.system(size: 12))
                        .foregroundColor(testIsSuccessfull == .successfull ? Color.Success : Color.Danger)
                        .offset(x:0, y:30)
                }
                
                Button {
                    viewModel.saveScript()
                    closeGroup()
                    viewModel.loadScripts()
                } label: {
                    HStack(alignment: .center) {
                        Text("save-script")
                        
                        Image(systemName: "checkmark")
                            .resizable()
                            .frame(width: 10, height: 10)
                            .foregroundColor(Color.Success)
                    }
                    .padding(Spacing.l)
                    .background(Color.Dark)
                    .clipShape(RoundedRectangle(cornerRadius: 10.0))
                    
                }
                .buttonStyle(.plain)
                .disabled(testIsRunning)
            }
            
        }
    }
}
