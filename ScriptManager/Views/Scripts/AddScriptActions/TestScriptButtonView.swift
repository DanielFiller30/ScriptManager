//
//  TestScriptButtonView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 10.02.23.
//

import SwiftUI

struct TestScriptButtonView: View {
    @StateObject var viewModel: ScriptsViewModel
    
    @Binding var testIsRunning: Bool
    @Binding var testResult: String
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
        
    }
    
    func testScript() async {
        testIsRunning = true
        
        testIsSuccessfull = await viewModel.runScript(viewModel.path, scriptName: viewModel.name, test: true)
        testResult = testIsSuccessfull == .successfull ? String(localized: "test-success") : String(localized: "test-failed")
        
        testIsRunning = false
    }
}

struct TestScriptButtonView_Previews: PreviewProvider {
    static var previews: some View {
        TestScriptButtonView(viewModel: ScriptsViewModel(), testIsRunning: .constant(false), testResult: .constant("Successfull"), testIsSuccessfull: .constant(.ready))
    }
}
