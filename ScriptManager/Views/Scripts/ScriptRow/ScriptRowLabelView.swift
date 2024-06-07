//
//  ScriptRowLabel.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 10.02.23.
//

import SwiftUI

struct ScriptRowLabel: View {
    @State private var vm = ScriptViewModel()
    
    var toggleDetails: () -> Void
    var script: Script
    
    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: script.icon)
                .resizable()
                .scaledToFit()
                .frame(height: IconSize.m)
                .padding(.horizontal, Spacing.m)
                .onTapGesture {
                    withAnimation() {
                        toggleDetails()
                    }
                }
            
            HStack(alignment: .center, spacing: Spacing.l) {
                Text(script.name)
                    .font(.system(size: FontSize.subTitle))
                    .fontWeight(.bold)
                    .lineLimit(1)
                    .onTapGesture {
                        toggleDetails()
                    }
                    .help(script.name)
                
                if script.tagID != EmptyTag.id {
                    if let tag = vm.getTagById(id: script.tagID) {
                        let badgeColor = try? ColorConverter.decodeColor(from: tag.badgeColor)
                        
                        BadgeView(
                            color: badgeColor ?? AppColor.Primary,
                            title: tag.name,
                            active: false
                        )
                    }
                }
            }
            
            Spacer()
            
            ScriptStateButtonView(script: script)
            
            ScriptRunButtonView(script: script)
        }
    }
}

struct ScriptRowLabelView_Previews: PreviewProvider {
    static var previews: some View {
        ScriptRowLabel(toggleDetails: {}, script: DefaultScript)
    }
}
