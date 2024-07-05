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
                        
            HStack(alignment: .center, spacing: Spacing.xl) {
                // Cancel
                CustomButtonView(
                    onClick: { vm.modalHandler.hideModal() },
                    label: "cancel",
                    color: AnyShapeStyle(.ultraThickMaterial),
                    outlined: false,
                    disabled: false
                )
                
                // Save tag
                CustomButtonView(
                    onClick: { vm.saveTag() },
                    label: "save-tag",
                    color: AnyShapeStyle(AppColor.Secondary),
                    outlined: false,
                    disabled: vm.name.isEmpty
                )
            }
        }
    }
}

struct TagModalView_Previews: PreviewProvider {
    static var previews: some View {
        TagModalView()
    }
}