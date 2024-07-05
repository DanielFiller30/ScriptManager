//
//  BadgeView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 22.03.23.
//

import SwiftUI

struct BadgeView: View {
    var color: Color
    var title: String
    var active: Bool
    var outlined: Bool?
    var filled: Bool?
    
    var body: some View {
        HStack(alignment: .center) {
            HStack {
                Text(title)
                    .fontWeight(.light)
                    .font(.system(size: FontSize.text))
                    .lineLimit(1)
                    .foregroundColor(active ? AppColor.AppBg : nil)
                
                if (filled ?? false == false) {
                    Circle()
                        .frame(maxWidth: 10, maxHeight: 10)
                        .foregroundColor(color)
                }
            }
            .padding(.horizontal, Spacing.l)
            .padding(.vertical, 7.0)
            .background(active ? AnyShapeStyle(AppColor.Creme) : (filled ?? false ? AnyShapeStyle(color) : AnyShapeStyle(.ultraThinMaterial)))
            .overlay(
                RoundedRectangle(cornerRadius: 12.0)
                    .stroke(outlined ?? true ? color : .clear, lineWidth: 1.5)
            )
            .shadow(radius: 3, x: 1, y: 2)
            .cornerRadius(12.0)
            .help(title)
        }
        .frame(maxWidth: 100)
    }
}

struct BadgeView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            BadgeView(color: AppColor.Primary, title: "Kurz", active: false)
        }
        .padding()
    }
}
