//
//  CustomButtonView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 31.03.23.
//

import SwiftUI

struct CustomButtonView: View {
    var onClick: () -> Void
    var label: LocalizedStringKey
    var color: AnyShapeStyle
    var outlined: Bool
    var disabled: Bool
    
    var body: some View {
        Button {
            onClick()
        } label: {
            HStack(alignment: .center) {
                Text(label)
                    .foregroundColor(.white)                    
            }
            .frame(maxWidth: .infinity)
            .padding(Spacing.l)
            .background(outlined ? AnyShapeStyle(.ultraThinMaterial) : color)
            .cornerRadius(10.0)
            .overlay(
                RoundedRectangle(cornerRadius: 10.0)
                    .stroke(color, lineWidth: outlined ? 1 : 0)
            )
            
        }
        .buttonStyle(.plain)
        .disabled(disabled)
    }
}

struct CustomButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CustomButtonView(onClick: {}, label: "", color: AnyShapeStyle(.black), outlined: false, disabled: false)
    }
}
