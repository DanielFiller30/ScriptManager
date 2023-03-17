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
    
    var label: LocalizedStringKey
    var info: LocalizedStringKey
    
    let content: () -> Content
    
    init(
        toggleVar: Binding<Bool>,
        toggle: @escaping () -> Void,
        label: LocalizedStringKey,
        info: LocalizedStringKey,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.toggleVar = toggleVar
        self.toggle = toggle
        self.label = label
        self.info = info
        self.content = content
    }
    
    var body: some View {
        DisclosureGroup(isExpanded: toggleVar) {
            content()
                .padding(.all, Spacing.xl)
        } label: {
            HStack(alignment: .center) {
                Text(label)
                    .fontWeight(.bold)
                    .font(.system(size: FontSize.subTitle))
                    .onTapGesture {
                        withAnimation {
                            toggle()
                        }
                    }
                    .padding(.trailing, Spacing.l)
                
                Text(info)
                    .fontWeight(.light)
                    .foregroundColor(AppColor.Creme)
                    .font(.system(size: FontSize.text))
                    .frame(maxWidth: 120)
                    .onTapGesture {
                        withAnimation {
                            toggle()
                        }                    }
            }
            .padding(.leading, Spacing.m)
            
        }
        .padding(.vertical, Spacing.m)
        .padding(.horizontal, Spacing.xl)
        
    }
}

struct GroupView_Previews: PreviewProvider {
    static var previews: some View {
        GroupView(toggleVar: .constant(false), toggle: {}, label: "Test", info: "Info-Test") {
            EmptyView()
        }
    }
}
