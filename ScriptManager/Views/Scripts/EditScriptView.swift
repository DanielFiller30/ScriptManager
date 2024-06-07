////
////  EditScriptView.swift
////  ScriptManager
////
////  Created by Filler, Daniel on 20.02.23.
////
//
//import SwiftUI
//
//struct EditScriptView: View {
//    @State private var vm = ScriptViewModel()
//    @Binding var showAddScriptModal: Bool
//    
//    var body: some View {
//        VStack(alignment: .leading) {
//            
//            VStack(alignment: .leading) {
//                Text("name-add-script")
//                    .font(.system(size: FontSize.text))
//                
//                TextField("", text: $vm.name)
//                
//            }
//            .padding(.bottom, Spacing.l)
//            
//            VStack(alignment: .leading) {
//                Text("icon-script")
//                    .font(.system(size: FontSize.text))
//                
//                IconPickerView()
//            }
//            .padding(.bottom, Spacing.l)
//            
//            HStack(alignment: .center) {
//                Text("tag-script")
//                    .font(.system(size: FontSize.text))
//                
//                Spacer()
//                
//                TagPickerView()
//            }
//            
//            VStack(alignment: .leading) {
//                HStack(alignment: .center) {
//                    Text("path-add-script")
//                        .font(.system(size: FontSize.text))
//                    
//                    HintView(title: "hint-script-title", text: "hint-script-text")
//                }
//                
//                TextField("cd /Desktop/ sh ...", text: $vm.command, axis: .vertical)
//                    .lineLimit(4, reservesSpace: true)
//                
//            }.padding(.bottom, Spacing.l)
//            
//            Spacer()
//            
//            // Save changed script
//            CustomButtonView(
//                onClick: { vm.saveChangedScript() },
//                label: "edit-save",
//                color: AppColor.Success,
//                outlined: false,
//                disabled: false
//            )
//            .padding(.bottom, Spacing.m)
//            
//            // Cancel
//            CustomButtonView(
//                onClick: {
//                    vm.editMode.toggle()
//                    showAddScriptModal.toggle()
//                },
//                label: "cancel",
//                color: AppColor.Creme,
//                outlined: true,
//                disabled: false
//            )
//        }
//        .padding(.all, Spacing.xl)
//    }
//}
//
//struct EditScriptView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditScriptView(showAddScriptModal: .constant(false))
//    }
//}
