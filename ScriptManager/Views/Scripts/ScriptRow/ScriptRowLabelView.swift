//
//  ScriptRowLabel.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 10.02.23.
//

import SwiftUI

struct ScriptRowLabel: View {
    @EnvironmentObject var settings: SettingsHandler
    
    var viewModel: ScriptViewModel
    var toggleDetails: () -> Void
    
    @Binding var script: Script
    @Binding var isRunning: Bool
    
    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: script.icon)
                .resizable()
                .scaledToFit()
                .foregroundColor(settings.mainColor)
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
                    .scaledToFit()
                    .onTapGesture {
                        withAnimation() {
                            toggleDetails()
                        }
                    }
                    .help(script.name)
                                
                let tag = viewModel.getTagById(id: script.tagID)
                
                if tag != nil {
                    BadgeView(color: ColorHandler.getDecodedColor(data: tag!.badgeColor), title: tag!.name, active: false)
                }
            }
            
            Spacer()
            
            ScriptStateButtonView(viewModel: viewModel, script: $script, isRunning: $isRunning)
            
            ScriptRunButtonView(viewModel: viewModel, script: $script, isRunning: $isRunning)
        }
    }
}

struct ScriptRowLabelView_Previews: PreviewProvider {
    static var previews: some View {
        ScriptRowLabel(viewModel: ScriptViewModel(), toggleDetails: {}, script: .constant(DefaultScript), isRunning: .constant(false))
    }
}
