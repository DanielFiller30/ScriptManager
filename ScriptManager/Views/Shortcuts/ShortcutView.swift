//
//  ShortcutView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 10.06.24.
//

import SwiftUI

struct ShortcutView: View {    
    var shortcut: Shortcut
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(Array(shortcut.keys), id: \.self) { char in
                Text("\(String(char))")
                    .font(.caption)
                    .padding(.vertical, Spacing.s)
                    .padding(.horizontal, Spacing.m)
                    .background(.gray)
                    .clipShape(RoundedRectangle(cornerRadius: 4.0))
            }
        }
    }
}

#Preview {
    ShortcutView(shortcut: Shortcut(shortcutIndex: 0, scriptId: UUID(), keys: "CMD"))
}
