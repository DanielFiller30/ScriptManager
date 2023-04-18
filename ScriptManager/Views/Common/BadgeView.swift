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
    
    var body: some View {
        HStack(alignment: .center) {
            Text(title)
                .fontWeight(.light)
                .font(.system(size: FontSize.text))
                .lineLimit(1)
                .foregroundColor(active ? AppColor.AppBg : nil)
            
            Circle()
                .frame(maxWidth: 10, maxHeight: 10)
                .foregroundColor(color)
        }
        .padding(.horizontal, Spacing.l)
        .padding(.vertical, Spacing.m)
        .background(active ? AppColor.Creme : AppColor.Light)
        .clipShape(RoundedRectangle(cornerRadius: 9.0))
        .help(title)
    }
}

struct BadgeView_Previews: PreviewProvider {
    static var previews: some View {
        BadgeView(color: AppColor.Primary, title: "Badge", active: false)
    }
}
