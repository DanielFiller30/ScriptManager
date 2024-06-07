//
//  SettingsShortcutView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 20.03.23.
//

import KeyboardShortcuts
import SwiftUI

struct SettingsShortcutView: View {
    @State private var vm = SettingsViewModel()
    private let shortcutLimit = 1...5
    
    func getDataByIndex(index: Int) -> DataModel {
        switch index {
        case 1:
            return DataModel(selection: vm.selectedScript1, shortcut: .runScript1)
        case 2:
            return DataModel(selection: vm.selectedScript2, shortcut: .runScript2)
        case 3:
            return DataModel(selection: vm.selectedScript3, shortcut: .runScript3)
        case 4:
            return DataModel(selection: vm.selectedScript4, shortcut: .runScript4)
        case 5:
            return DataModel(selection: vm.selectedScript5, shortcut: .runScript5)
        default:
            return DataModel(selection: vm.selectedScript1, shortcut: .runScript1)
        }
    }
    
    var body: some View {
        VStack(alignment: .center) {
            ForEach(Array(shortcutLimit.enumerated()), id: \.element) { index, number in
//                let data = getDataByIndex(index: number)
//                
//                HStack(alignment: .center) {
//                    Text(EmptyScript.name)
//                        .tag(EmptyScript.id)
//                    
//                    Picker("", selection: data.selection) {
//                        Text(EmptyScript.name).tag(EmptyScript.id)
//                        
//                        ForEach(vm.settings.scripts, id: \.self.id) {
//                            Text($0.name).tag($0.id)
//                        }
//                    }
//                    
//                    Spacer()
//                    
//                    KeyboardShortcuts.Recorder("", name: data.shortcut)
//                }
//                .padding(.bottom, Spacing.m)
            }
        }
        .padding(.top, Spacing.l)
    }
}

struct SettingsShortcutView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsShortcutView()
    }
}

struct DataModel {
    var selection: UUID
    var shortcut: KeyboardShortcuts.Name
}
