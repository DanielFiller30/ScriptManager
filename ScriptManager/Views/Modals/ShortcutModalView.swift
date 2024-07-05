//
//  ShortcutModalView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 07.06.24.
//

import KeyboardShortcuts
import SwiftUI

struct ShortcutModalView: View {
    @State private var vm = ShortcutViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                Text("shortcut-script")
                    .font(.system(size: FontSize.text))
                
                Spacer()
                
                Picker("", selection: $vm.scriptId) {
                    ForEach(vm.scripts) { script in
                        Text(script.name)
                            .tag(script.id)
                    }
                }
            }
            .padding(.bottom, Spacing.l)
            
            HStack(alignment: .center) {
                Text("shortcut-keys")
                    .font(.system(size: FontSize.text))
                
                Spacer()
                
                KeyboardShortcuts.Recorder(for: .runScript1) { keys in
                    guard let keys else { return }
                    vm.keys = keys.description
                }
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
                    onClick: { vm.saveShortcut() },
                    label: "save-shortcut",
                    color: AnyShapeStyle(AppColor.Secondary),
                    outlined: false,
                    disabled: vm.scriptId == EmptyScript.id || vm.keys.isEmpty
                )
            }
        }
    }
}

#Preview {
    ShortcutModalView()
}
