//
//  ScriptDeleteButtonView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 10.02.23.
//

import SwiftUI

struct ScriptDeleteButtonView: View {
    @State private var vm =  ScriptViewModel()
    var scriptId: UUID
    var disabled: Bool
    
    var body: some View {
        Button {
            vm.showDeleteScriptAlert(id: scriptId)
        } label: {
            Image(systemName: "trash")
                .resizable()
                .frame(width: IconSize.s, height: IconSize.s)
                .padding(Spacing.l)
        }
        .buttonStyle(.plain)
        .disabled(disabled)
        .help("button-delete")
    }
}

struct ScriptDeleteButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ScriptDeleteButtonView(scriptId: UUID(), disabled: false)
    }
}
