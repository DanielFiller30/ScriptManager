//
//  AddScriptView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 03.02.23.
//

import SwiftUI

struct AddScriptView: View {
    @StateObject var viewModel: ScriptViewModel
    
    @State var testIsRunning: Bool = false
    @State var testResult: LocalizedStringKey = ""
    @State var testIsSuccessfull: ResultState = .ready
    
    
    var body: some View {
        VStack(alignment: .leading) {
            
            VStack(alignment: .leading) {
                Text("name-add-script")
                    .font(.system(size: FontSize.text))
                
                TextField("", text: $viewModel.name)
                
            }
            .padding(.bottom, Spacing.l)
            
            VStack(alignment: .leading) {
                Text("icon-script")
                    .font(.system(size: FontSize.text))
                
                IconPickerView(viewModel: viewModel)
            }
            .padding(.bottom, Spacing.l)
            
            VStack(alignment: .leading) {
                HStack(alignment: .center) {
                    Text("path-add-script")
                        .font(.system(size: FontSize.text))
                    
                    HintView(title: "hint-script-title", text: "hint-script-text")
                }
                
                TextField("cd /Desktop/ sh ...", text: $viewModel.command, axis: .vertical)
                    .lineLimit(4, reservesSpace: true)
                
            }.padding(.bottom, Spacing.l)
            
            HStack(alignment: .center) {
                TestScriptButtonView(viewModel: viewModel, testIsRunning: $testIsRunning, testResult: $testResult, testIsSuccessfull: $testIsSuccessfull)
                
                Spacer()
                
                SaveScriptButtonView(viewModel: viewModel, testIsRunning: $testIsRunning)
            }
            
            Text(testResult)
                .font(.system(size: FontSize.subTitle))
                .foregroundColor(testIsSuccessfull == .successfull ? AppColor.Success : AppColor.Danger)
                .padding(.top, Spacing.m)
            
        }
        .frame(height: 305)
    }
}

struct AddScriptView_Previews: PreviewProvider {
    static var previews: some View {
        AddScriptView(viewModel: ScriptViewModel())
    }
}
