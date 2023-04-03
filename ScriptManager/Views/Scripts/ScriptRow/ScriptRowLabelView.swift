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
                                
                let category = viewModel.getCategoryById(id: script.categoryID)
                
                if category != nil {
                    BadgeView(color: viewModel.getDecodedColor(data: category!.badgeColor), title: category!.name, active: false)
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
