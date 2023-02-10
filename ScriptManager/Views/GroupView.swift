//
//  GroupView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 05.02.23.
//

import SwiftUI

struct GroupView: View {
    var toggleVar: Binding<Bool>
    var toggle: () -> Void
    
    var label: String
    var info: String

    var view: AnyView
    
    var body: some View {
        DisclosureGroup(isExpanded: toggleVar) {
            view
                .padding(.all, Spacing.xl)
        } label: {
            HStack(alignment: .center) {
                Text(label)
                    .fontWeight(.bold)
                    .font(.system(size: Font.subTitle))
                    .onTapGesture {
                        withAnimation {
                            toggle()
                        }
                    }
                    .padding(.trailing, Spacing.l)
                                
                Text(info)
                    .fontWeight(.light)
                    .foregroundColor(Color.Creme)
                    .font(.system(size: Font.text))
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
