//
//  ShortcutView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 10.06.24.
//

import SwiftUI

struct ShortcutView: View {
    @State private var vm = ShortcutViewModel()
    
    var shortcut: Shortcut
    
    var body: some View {
        Button {
            Task {
                await vm.runScript(scriptId: shortcut.scriptId)
            }
        } label: {
            VStack(alignment: .leading) {
                Text(vm.scripts.first(where: { $0.id == shortcut.scriptId })?.name ?? "NO NAME")
                    .font(.subheadline)
                
                HStack(alignment: .center) {
                    Spacer()
                    
                    ForEach(Array(shortcut.keys), id: \.self) { char in
                        Text("\(String(char))")
                            .font(.caption)
                            .padding(Spacing.m)
                            .foregroundColor(.black)
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 4.0))
                    }
                    
                    Spacer()
                }
            }
            .padding(Spacing.l)
            .background(.ultraThinMaterial)
            .cornerRadius(12.0)
            .overlay(
                RoundedRectangle(cornerRadius: 12.0)
                    .stroke(.white, lineWidth: 0.5)
            )
            .shadow(radius: 3, x: 1, y: 2)
        }
        .buttonStyle(.plain)
        .disabled(vm.runningScripts.contains(where: { $0.id == shortcut.scriptId }))
    }
}

#Preview {
    ShortcutView(shortcut: Shortcut(shortcutIndex: 0, scriptId: UUID(), keys: "CMD"))
}
