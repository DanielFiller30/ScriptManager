//
//  IconPickerView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 20.02.23.
//

import SwiftUI

struct IconPickerView: View {
    @State private var vm = ScriptViewModel()
    
    var body: some View {
        Form {
            Picker(selection: $vm.scriptHandler.selectedIcon, label: EmptyView()) {
                Section(header: Text("Icons")) {
                    ForEach(ScriptIcons.indices, id: \.self) { (i) in
                        HStack {
                            Image(systemName: ScriptIcons[i])
                            Text(ScriptIcons[i].replacingOccurrences(of: ".", with: " "))
                        }
                        .tag(i)
                    }
                }
            }
            .frame(maxWidth: 145)
            .padding(.leading, -8)
        }
    }
}

struct IconPickerView_Previews: PreviewProvider {
    static var previews: some View {
        IconPickerView()
    }
}
