//
//  ShortcutListView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 07.06.24.
//

import SwiftUI
import KeyboardShortcuts

struct ShortcutListView: View {
    @State private var vm = ShortcutViewModel()
    @State private var showShortcuts = false
    
    var body: some View {
        DisclosureGroup(isExpanded: $showShortcuts) {
            VStack(alignment: .leading, spacing: Spacing.l) {
                if (vm.shortcuts.isEmpty) {
                    Text("empty-shortcuts")
                        .font(.system(size: FontSize.text))
                        .foregroundColor(AppColor.Creme)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                } else {
                    ScrollView(.horizontal) {
                        HStack(spacing: Spacing.l) {
                            ForEach(vm.shortcuts, id: \.self) { shortcut in
                                ShortcutView(shortcut: shortcut)
                            }
                            .padding(2)
                        }
                        .padding(.bottom, Spacing.l)
                    }
                }
            }
            .padding(.top, Spacing.xl)
        } label: {
            HStack(alignment: .center) {
                Text("shortcuts")
                    .fontWeight(.bold)
                    .font(.system(size: FontSize.subTitle))
                
                Spacer()
                
                Button {
                    vm.modalHandler.showShortcutModal()
                } label: {
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: IconSize.s, height: IconSize.s)
                        .foregroundColor(Color.white)
                        .help("add-new-shortcut")
                }
                .buttonStyle(.plain)
                .disabled(vm.scripts.isEmpty)
            }
            .padding(.leading, Spacing.m)
            .onTapGesture {
                withAnimation {
                    showShortcuts.toggle()
                }
            }
        }
        .padding(.horizontal, Spacing.xl)
        .padding(.vertical, Spacing.l)
        .fixedSize(horizontal: false, vertical: true)
    }
}

#Preview {
    ShortcutListView()
}
