//
//  AddScriptButtonView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 05.02.23.
//

import SwiftUI

struct AddScriptButtonView: View {
    @StateObject private var viewModel = ScriptsViewModel()
    @State var testResult: String = ""
    @State var testIsSuccessfull: ResultState = .ready
   
    var testIsRunning: Bool
    var action: () -> Void

    var body: some View {
        ZStack(alignment: .center) {
            Button {
                Task {
                    testIsRunning = true
                    testIsSuccessfull = await viewModel.runScript(viewModel.path)
                    testResult = testIsSuccessfull == .successfull ? "Script worked" : "Script failed"
                    testIsRunning = false
                }
            } label: {
                HStack(alignment: .center) {
                    Text("Test script")
                    
                    if (!testIsRunning) {
                        Image(systemName: "play")
                            .resizable()
                            .frame(width: 13, height: 13)
                            .foregroundColor(Color.Dark)
                        
                    } else {
                        ProgressView()
                            .frame(width: 13, height: 13)
                            .scaleEffect(0.5)
                            .progressViewStyle(.circular)
                    }
                    
                }
                .padding(Spacing.l)
                .background(Color.Light)
                .clipShape(RoundedRectangle(cornerRadius: 10.0))
                
            }
            .buttonStyle(.plain)
            .disabled(testIsRunning)
            
            Text(testResult)
                .font(.system(size: 12))
                .foregroundColor(testIsSuccessfull == .successfull ? Color.Success : Color.Danger)
                .offset(x:0, y:30)
        }    }
}

struct AddScriptButtonView_Previews: PreviewProvider {
    static var previews: some View {
        AddScriptButtonView()
    }
}
