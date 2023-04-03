//
//  SettingsShortcutView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 20.03.23.
//

import KeyboardShortcuts
import SwiftUI

struct SettingsShortcutView: View {
    @EnvironmentObject var settings: SettingsHandler
    
    private var scripts: [Script] = []

    private let storage: StorageHandler = StorageHandler()
    private let shortcutLimit = 5
    
    init() {
        debugPrint("Scripts Loaded")
        self.scripts = storage.loadScripts() ?? []
        self.scripts.append(EmptyScript)
    }
    
    func getDataByIndex(index: Int) -> DataModel {
        switch index {
        case 1:
            return DataModel(selection: $settings.selectedScript1, shortcut: .runScript1)
        case 2:
            return DataModel(selection: $settings.selectedScript2, shortcut: .runScript2)
        case 3:
            return DataModel(selection: $settings.selectedScript3, shortcut: .runScript3)
        case 4:
            return DataModel(selection: $settings.selectedScript4, shortcut: .runScript4)
        case 5:
            return DataModel(selection: $settings.selectedScript5, shortcut: .runScript5)
        default:
            return DataModel(selection: $settings.selectedScript1, shortcut: .runScript1)
        }
    }
    
    var body: some View {
        VStack(alignment: .center) {
            ForEach((1...shortcutLimit), id: \.self) { index in
                let data = getDataByIndex(index: index)
                
                HStack(alignment: .center) {
                    Picker("", selection: data.selection) {
                        ForEach(scripts, id: \.self.id) {
                            Text($0.name).tag($0.id)
                        }
                    }
                    
                    Spacer()
                    
                    KeyboardShortcuts.Recorder("", name: data.shortcut)
                }
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
    var selection: Binding<UUID>
    var shortcut: KeyboardShortcuts.Name
}
