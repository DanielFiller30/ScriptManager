//
//  TestScriptButtonView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 10.02.23.
//

import SwiftUI

struct TestScriptButtonView: View {
    @StateObject var viewModel: ScriptViewModel
    let scriptHandler: ScriptHandler = ScriptHandler()
    
    @Binding var testIsRunning: Bool
    @Binding var testResult: LocalizedStringKey
    @Binding var testIsSuccessfull: ResultState
    
    var body: some View {
        Button {
            Task {
                await testScript()
            }
        } label: {
            HStack(alignment: .center) {
                Text("test-script")
                    .padding(.trailing, Spacing.m)
                
                if (!testIsRunning) {
                    Image(systemName: "play")
                        .resizable()
                        .frame(width: IconSize.s, height: IconSize.s)
                        .foregroundColor(AppColor.Creme)
                    
                } else {
                    ProgressView()
                        .frame(width: 10, height: 10)
                        .scaleEffect(0.5)
                        .progressViewStyle(.circular)
                }
                
            }
            .padding(Spacing.l)
            .background(AppColor.Dark)
            .clipShape(RoundedRectangle(cornerRadius: 10.0))
            
        }
        .buttonStyle(.plain)
        .disabled(testIsRunning || viewModel.command.isEmpty)
        
    }
    
    func testScript() async {
        testIsRunning = true
        
        let tempScript: Script = Script(name: viewModel.name, icon: "", command: viewModel.command, success: .ready, finished: false)
        testIsSuccessfull = await scriptHandler.runScript(tempScript, test: true)
        testResult = testIsSuccessfull == .successfull ? "test-success" : "test-failed"
        
        testIsRunning = false
    }
}

struct TestScriptButtonView_Previews: PreviewProvider {
    static var previews: some View {
        TestScriptButtonView(viewModel: ScriptViewModel(), testIsRunning: .constant(false), testResult: .constant("Successfull"), testIsSuccessfull: .constant(.ready))
    }
}
