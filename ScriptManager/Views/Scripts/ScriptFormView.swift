//
//  AddScriptView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 03.02.23.
//

import SwiftUI

struct ScriptFormView: View {
    @StateObject var viewModel: ScriptViewModel
    let scriptHandler: ScriptHandler = ScriptHandler()
    
    @State var testIsRunning: Bool = false
    @State var testResult: LocalizedStringKey = ""
    @State var testIsSuccessfull: ResultState = .ready
    
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack(alignment: .center) {
                Text("name-add-script")
                    .font(.system(size: FontSize.text))
                
                Spacer()
                
                TextField("", text: $viewModel.name)
                    .frame(maxWidth: 140)
            }
            .padding(.bottom, Spacing.l)
            
            HStack(alignment: .center) {
                Text("icon-script")
                    .font(.system(size: FontSize.text))
                
                Spacer()
                
                IconPickerView(viewModel: viewModel)
            }
            .padding(.bottom, Spacing.l)
            
            HStack(alignment: .center) {
                Text("tag-script")
                    .font(.system(size: FontSize.text))
                
                Spacer()
                
                TagPickerView(viewModel: viewModel)
            }
            
            Divider()
                .padding(.vertical, Spacing.l)
            
            VStack(alignment: .leading) {
                HStack(alignment: .center) {
                    Text("path-add-script")
                        .font(.system(size: FontSize.text))
                    
                    HintView(title: "hint-script-title", text: "hint-script-text")
                    
                    Spacer()
                    
                    Text(testResult)
                        .font(.system(size: FontSize.subTitle))
                        .foregroundColor(testIsSuccessfull == .successfull ? AppColor.Success : AppColor.Danger)
                }
                
                TextField("cd /Desktop/ sh ...", text: $viewModel.command, axis: .vertical)
                    .lineLimit(4, reservesSpace: true)
                
            }.padding(.bottom, Spacing.l)
            
            // Save script
            CustomButtonView(
                onClick: {
                    if viewModel.editMode {
                        viewModel.saveChangedScript()
                    } else {
                        viewModel.saveScript()
                    }
                    
                    viewModel.showAddScript.toggle()
                },
                label: viewModel.editMode ? "edit-save" : "save-script",
                color: AppColor.Success,
                outlined: false,
                disabled: testIsRunning || viewModel.name.isEmpty || viewModel.command.isEmpty
            )
            .padding(.bottom, Spacing.m)
            
            // Test script
            CustomButtonView(
                onClick: { testScript() },
                label: "test-script",
                color: AppColor.Success,
                outlined: true,
                disabled: testIsRunning || viewModel.command.isEmpty
            )
            .padding(.bottom, Spacing.m)
            
            // Cancel
            CustomButtonView(
                onClick: { viewModel.showAddScript.toggle() },
                label: "cancel",
                color: AppColor.Creme,
                outlined: true,
                disabled: false
            )
        }
        .padding(.all, Spacing.xl)
    }
    
    func testScript() {
        testIsRunning = true
        
        let tempScript: Script = Script(name: viewModel.name, icon: "", command: viewModel.command, success: .ready, finished: false)
        
        Task {
            testIsSuccessfull = await scriptHandler.runScript(tempScript, test: true)
            testResult = testIsSuccessfull == .successfull ? "test-success" : "test-failed"
            
            testIsRunning = false
        }
    }
}

struct AddScriptView_Previews: PreviewProvider {
    static var previews: some View {
        ScriptFormView(viewModel: ScriptViewModel())
    }
}
