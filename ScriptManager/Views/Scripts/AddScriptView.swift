//
//  AddScriptView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 03.02.23.
//

import SwiftUI

struct AddScriptView: View {
    @StateObject var viewModel: ScriptsViewModel
    var closeGroup: () -> Void

    @State var testIsRunning: Bool = false
    @State var testResult: String = ""
    @State var testIsSuccessfull: ResultState = .ready
    
    
    var body: some View {
        VStack(alignment: .leading) {
            
            VStack(alignment: .leading) {
                Text("name-add-script")
                    .font(.system(size: Font.text))
                
                TextField("", text: $viewModel.name)
                
            }
            .padding(.bottom, Spacing.l)
            
            VStack(alignment: .leading) {
                Text("path-add-script")
                    .font(.system(size: Font.text))
                
                TextField("cd /Desktop/ sh ...", text: $viewModel.path, axis: .vertical)
                    .lineLimit(4, reservesSpace: true)
                
            }.padding(.bottom, Spacing.l)
            
            HStack(alignment: .center) {
                TestScriptButtonView(viewModel: viewModel, testIsRunning: $testIsRunning, testResult: $testResult, testIsSuccessfull: $testIsSuccessfull)
                
                Spacer()
                
                SaveScriptButtonView(viewModel: viewModel, closeGroup: { closeGroup() }, testIsRunning: $testIsRunning)
            }
            
            Text(testResult)
                .font(.system(size: Font.subTitle))
                .foregroundColor(testIsSuccessfull == .successfull ? Color.Success : Color.Danger)
                .padding(.top, Spacing.m)
            
        }
    }
}
