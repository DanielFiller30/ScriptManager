//
//  AddTagView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 22.03.23.
//

import SwiftUI

struct TagModalView: View {
    @State private var vm = TagViewModel()
    let colors: [Color] = [.brown, .cyan, .indigo, .mint, .pink, .green, .blue, .orange, .purple, .red]
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                Text("name-add-tag")
                    .font(.headline)
                
                Spacer()
                
                TextField("", text: $vm.name)
                    .frame(maxWidth: 155)
                    .cornerRadius(8)
                    .textFieldStyle(.roundedBorder)
            }
            .padding(.bottom, Spacing.l)
            
            HStack(alignment: .center) {
                Text("color-add-tag")
                    .font(.headline)
                                
                Spacer()
                
                Picker("", selection: $vm.badgeColor) {
                    ForEach(colors, id: \.self) { color in
                        Text(color.description.capitalized)
                            .foregroundStyle(color)
                    }
                }
                .pickerStyle(.menu)
                .frame(width: 100)
                
                ColorPicker("", selection: $vm.badgeColor)
            }
            .padding(.bottom, Spacing.l)
            
            Divider()
                .padding(.vertical, Spacing.l)
            
            Text("presets")
                .font(.headline)
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(vm.presets, id: \.self) { preset in
                        Button {
                            vm.name = preset.title
                            vm.badgeColor = preset.color
                        } label: {
                            HStack(alignment: .center) {
                                Image(systemName: preset.icon)
                                
                                Text(preset.title)
                                    .font(.caption)
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 10)
                            .background(.ultraThickMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            
            Divider()
                .padding(.vertical, Spacing.l)
                        
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
                    color: AnyShapeStyle(AppColor.Primary),
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
