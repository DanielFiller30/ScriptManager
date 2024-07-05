//
//  ScriptModalView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 06.06.24.
//

import Resolver
import SwiftUI

struct ScriptModalView: View {
    @State private var vm = ScriptViewModel()
    
    @State var testIsRunning: Bool = false
    @State var testResult: LocalizedStringKey = ""
    @State var testIsSuccessfull: ResultState = .ready
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                Text("name-add-script")
                    .font(.system(size: FontSize.text))
                
                Spacer()
                
                TextField("", text: $vm.scriptHandler.editScript.name)
                    .frame(maxWidth: 140)
            }
            .padding(.bottom, Spacing.l)
            
            HStack(alignment: .center) {
                Text("icon-script")
                    .font(.system(size: FontSize.text))
                
                Spacer()
                
                IconPickerView()
            }
            .padding(.bottom, Spacing.l)
            
            HStack(alignment: .center) {
                Text("tag-script")
                    .font(.system(size: FontSize.text))
                
                Spacer()
                
                TagPickerView()
            }
            
            Divider()
                .padding(.vertical, Spacing.l)
            
            VStack(alignment: .leading) {
                HStack(alignment: .center) {
                    Text("path-add-script")
                        .font(.system(size: FontSize.text))
                    
                    HintView(title: "hint-script-title", text: "hint-script-text")
                    
                    Spacer()
                    
                    Button {
                        testScript()
                    } label: {
                        Text("test-script")
                            .padding(.vertical, Spacing.m)
                            .padding(.horizontal, Spacing.l)
                            .background(.ultraThickMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 10.0))
                    }
                    .buttonStyle(.plain)
                    
                    Text(testResult)
                        .font(.system(size: FontSize.subTitle))
                        .foregroundColor(testIsSuccessfull == .successfull ? AppColor.Success : AppColor.Danger)
                }
                
                TextField("cd /Desktop/ sh ...", text: $vm.scriptHandler.editScript.command, axis: .vertical)
                    .lineLimit(4, reservesSpace: true)
                
            }.padding(.bottom, Spacing.l)
            
            HStack(alignment: .center, spacing: Spacing.xl) {
                // Cancel
                CustomButtonView(
                    onClick: { vm.modalHandler.hideModal() },
                    label: "cancel",
                    color: AnyShapeStyle(.ultraThickMaterial),
                    outlined: false,
                    disabled: false
                )
                
                // Save script
                CustomButtonView(
                    onClick: {
                        if vm.editMode {
                            vm.saveChangedScript()
                        } else {
                            vm.saveScript()
                        }
                        
                        vm.modalHandler.hideModal()
                    },
                    label: vm.editMode ? "edit-save" : "save-script",
                    color: AnyShapeStyle(AppColor.Success),
                    outlined: false,
                    disabled: testIsRunning || vm.scriptHandler.editScript.name.isEmpty || vm.scriptHandler.editScript.command.isEmpty
                )
            }
        }      
    }
    
    // TODO: Move function to vm
    func testScript() {
        testIsRunning = true
        
        let tempScript: Script = Script(
            name: vm.scriptHandler.editScript.name,
            icon: "terminal",
            command: vm.scriptHandler.editScript.command,
            success: .ready,
            finished: false
        )
        
        Task {
            testIsSuccessfull = await vm.scriptHandler.runScript(tempScript, test: true)
            testResult = testIsSuccessfull == .successfull ? "test-success" : "test-failed"
            
            testIsRunning = false
        }
    }
}

struct ScriptModalView_Previews: PreviewProvider {
    static var previews: some View {
        ScriptModalView()
    }
}