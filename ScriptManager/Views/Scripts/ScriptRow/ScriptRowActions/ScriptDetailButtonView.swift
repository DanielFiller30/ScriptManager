//
//  ScriptDetailButtonView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 01.04.23.
//

import SwiftUI

struct ScriptDetailButtonView: View {
    var onClick: () -> Void
    var icon: String
    var disabled: Bool
    var help: LocalizedStringKey
    
    var body: some View {
        Button {
            onClick()
        } label: {
            Image(systemName: icon)
                .resizable()
                .frame(width: IconSize.s, height: IconSize.s)
                .padding(Spacing.l)
                .background(.ultraThickMaterial)
                .clipShape(Circle())
        }
        .buttonStyle(.plain)
        .disabled(disabled)
        .help(help)
    }
}

struct ScriptDetailButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ScriptDetailButtonView(onClick: {}, icon: "xmark", disabled: false, help: "Preview")
    }
}
