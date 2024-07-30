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
                    .font(.subheadline)
                
                Spacer()
                
                TextField("", text: $vm.tagHandler.editTag.name)
                    .frame(maxWidth: 155)
                    .cornerRadius(8)
                    .textFieldStyle(.roundedBorder)
            }
            .padding(.bottom, Spacing.l)
            
            HStack(alignment: .center) {
                Text("color-add-tag")
                    .font(.subheadline)
                
                Spacer()
                
                Picker("", selection: $vm.tagHandler.editColor) {
                    ForEach(colors, id: \.self) { color in
                        Text(color.description.capitalized)
                            .foregroundStyle(color)
                    }
                }
                .pickerStyle(.menu)
                .frame(width: 100)
                
                ColorPicker("", selection: $vm.tagHandler.editColor)
            }
            .padding(.bottom, Spacing.l)
            
            Divider()
                .padding(.vertical, Spacing.l)
            
            Text("presets")
                .font(.subheadline)
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(TagPresets, id: \.self) { preset in
                        Button {
                            vm.tagHandler.editTag.name = preset.title
                            vm.tagHandler.editColor = preset.color
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
                    onClick: { vm.hideModal() },
                    label: "cancel",
                    color: AnyShapeStyle(.ultraThickMaterial),
                    outlined: false,
                    disabled: false
                )
                
                // Save tag
                CustomButtonView(
                    onClick: {
                        if vm.editMode {
                            vm.saveChangedTag()
                        } else {
                            vm.saveTag()
                        }
                    },
                    label: vm.editMode ? "save-changed-tag" : "save-tag",
                    color: AnyShapeStyle(AppColor.Primary),
                    outlined: false,
                    disabled: vm.tagHandler.editTag.name.isEmpty
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
