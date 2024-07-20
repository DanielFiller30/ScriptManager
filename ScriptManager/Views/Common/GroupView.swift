//
//  GroupView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 05.02.23.
//

import SwiftUI
import Foundation

struct GroupView<Content>: View where Content: View {
    var toggleVar: Binding<Bool>
    var toggle: () -> Void
    var padding: CGFloat?
    var animation: Bool
    
    var label: LocalizedStringKey
    var info: LocalizedStringKey?
    
    let content: () -> Content
    
    init(
        toggleVar: Binding<Bool>,
        toggle: @escaping () -> Void,
        label: LocalizedStringKey,
        info: LocalizedStringKey?,
        padding: CGFloat?,
        animation: Bool,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.toggleVar = toggleVar
        self.toggle = toggle
        self.label = label
        self.info = info
        self.padding = padding
        self.animation = animation
        self.content = content
    }
    
    var body: some View {
        DisclosureGroup(isExpanded: toggleVar) {
            content()
                .padding(.all, self.padding == nil ? Spacing.xl : self.padding)
        } label: {
            HStack(alignment: .center) {
                Text(label)
                    .font(.headline)
                    .onTapGesture {
                        if animation {
                            withAnimation {
                                toggle()
                            }
                        } else {
                            toggle()
                        }
                    }
                    .padding(.trailing, Spacing.m)
                
                Spacer()
                
                if self.info != nil {
                    Text(info!)
                        .fontWeight(.light)
                        .foregroundColor(AppColor.Creme)
                        .font(.system(size: FontSize.text))
                        .frame(maxWidth: 180)
                        .onTapGesture {
                            if animation {
                                withAnimation {
                                    toggle()
                                }
                            } else {
                                toggle()
                            }
                        }
                        .help(info!)
                }
            }
            .padding(.leading, Spacing.m)
            .fixedSize(horizontal: false, vertical: true)
        }
    }
}

struct GroupView_Previews: PreviewProvider {
    static var previews: some View {
        GroupView(toggleVar: .constant(false), toggle: {}, label: "Test", info: nil, padding: nil, animation: true) {
            EmptyView()
        }
    }
}
