//
//  SettingsShortcutView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 20.03.23.
//

import KeyboardShortcuts
import SwiftUI

struct SettingsShortcutView: View {
    @Binding var vm: SettingsViewModel
    
    var body: some View {
        VStack(alignment: .center) {
            ScriptShortcutView(vm: $vm, selectedScript: $vm.selectedScript1, selectedKeys: $vm.selectedKeys1, selectedShortcut: .runScript1)
            ScriptShortcutView(vm: $vm, selectedScript: $vm.selectedScript2, selectedKeys: $vm.selectedKeys2, selectedShortcut: .runScript2)
            ScriptShortcutView(vm: $vm, selectedScript: $vm.selectedScript3, selectedKeys: $vm.selectedKeys3, selectedShortcut: .runScript3)
            ScriptShortcutView(vm: $vm, selectedScript: $vm.selectedScript4, selectedKeys: $vm.selectedKeys4, selectedShortcut: .runScript4)
            ScriptShortcutView(vm: $vm, selectedScript: $vm.selectedScript5, selectedKeys: $vm.selectedKeys5, selectedShortcut: .runScript5)
        }
        .padding(.top, Spacing.l)
    }
}

struct ScriptShortcutView: View {
    @Binding var vm: SettingsViewModel
    @Binding var selectedScript: UUID
    @Binding var selectedKeys: String
    var selectedShortcut: KeyboardShortcuts.Name
    
    var body: some View {
        HStack(alignment: .center) {
            Text(EmptyScript.name)
                .tag(EmptyScript.id)
            
            ScriptPicker(vm: vm, selectedScript: $selectedScript)
            
            Spacer()
            
            KeyboardShortcuts.Recorder("", name: selectedShortcut) { keys in
                guard let keys else { return }
                selectedKeys = keys.description
            }
        }
        .padding(.bottom, Spacing.m)
    }
}

struct ScriptPicker: View {
    var vm: SettingsViewModel
    @Binding var selectedScript: UUID
    
    var body: some View {
        VStack {
            Picker("", selection: $selectedScript) {
                Text(EmptyScript.name).tag(EmptyScript.id)
                
                ForEach(vm.scriptHandler.scripts, id: \.self.id) {
                    Text($0.name).tag($0.id)
                }
            }
        }
    }
}

struct SettingsShortcutView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsShortcutView(vm: .constant(SettingsViewModel()))
    }
}
