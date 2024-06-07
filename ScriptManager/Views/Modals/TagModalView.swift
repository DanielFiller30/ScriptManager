//
//  AddTagView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 22.03.23.
//

import SwiftUI

struct TagModalView: View {
    @State private var vm = TagViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                Text("name-add-tag")
                    .font(.system(size: FontSize.text))
                
                Spacer()
                
                TextField("", text: $vm.name)
                    .frame(maxWidth: 120)
            }
            .padding(.bottom, Spacing.l)
            
            HStack(alignment: .center) {
                Text("color-add-tag")
                    .font(.system(size: FontSize.text))
                                
                Spacer()
                
                ColorPicker("", selection: $vm.badgeColor)
            }
            .padding(.bottom, Spacing.l)
                        
            // Save tag
            CustomButtonView(
                onClick: { vm.saveTag() },
                label: "save-tag",
                color: AppColor.Success,
                outlined: false,
                disabled: vm.name.isEmpty
            )
            .padding(.bottom, Spacing.m)
            
            // Cancel
            CustomButtonView(
                onClick: { vm.modalHandler.hideModal() },
                label: "cancel",
                color: AppColor.Creme,
                outlined: true,
                disabled: false
            )
        }
    }
}

struct TagModalView_Previews: PreviewProvider {
    static var previews: some View {
        TagModalView()
    }
}
