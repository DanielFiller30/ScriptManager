//
//  HelpView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 10.02.23.
//

import SwiftUI

struct HelpView: View {
    var title: LocalizedStringKey
    var text: LocalizedStringKey
    
    @State var showHint: Bool = false
    
    var body: some View {
        Button {
            showHint.toggle()
        } label: {
            Image(systemName: "questionmark.square.dashed")
                .resizable()
                .frame(width: IconSize.m, height: IconSize.m)
        }
        .buttonStyle(.plain)
        .popover(isPresented: $showHint) {
            VStack(alignment: .center) {
                Text(title)
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, Spacing.l)
                    .padding(.top, Spacing.xl)
                
                Divider()
                
                Text(text)
                    .font(.caption)
                    .multilineTextAlignment(.center)
                    .lineLimit(10)
                    .padding(Spacing.l)
                
                Spacer()
                
            }
            .frame(maxWidth: 200, minHeight: 200)
        }
    }
}

struct HintView_Previews: PreviewProvider {
    static var previews: some View {
        HelpView(title: "Test", text: "Info text")
    }
}
