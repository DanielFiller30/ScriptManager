//
//  ScriptRowLabel.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 10.02.23.
//

import SwiftUI

struct ScriptRowLabel: View {
    var viewModel: ScriptsViewModel
    var toggleDetails: () -> Void
    
    @Binding var script: Script
    
    @State var isLogEnabled: Bool = DefaultSettings.logs
    @State var isRunning: Bool = false
    
    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: script.icon)
                .resizable()
                .scaledToFit()
                .foregroundColor(Color.Primary)
                .frame(height: IconSize.m)
                .padding(.horizontal, Spacing.m)
                .onTapGesture {
                    withAnimation() {
                        toggleDetails()
                    }
                }
            
            Text(script.name)
                .font(.system(size: FontSize.subTitle))
                .fontWeight(.bold)
                .frame(maxWidth: 110, alignment: .leading)
                .lineLimit(1)
                .onTapGesture {
                    withAnimation() {
                        toggleDetails()
                    }
                }
            
            Spacer()
            
            ScriptStateButtonView(viewModel: viewModel, script: $script, isRunning: $isRunning, isLogEnabled: $isLogEnabled)
            
            ScriptRunButtonView(viewModel: viewModel, reloadSettings: { reloadSettings() }, script: $script, isRunning: $isRunning)
            
            ScriptDeleteButtonView(viewModel: viewModel, scriptId: $script.id, isRunning: $isRunning)
        }
        .onAppear() {
            reloadSettings()
        }
    }
    
    func reloadSettings() {
        let storage = StorageHandler()
        let settings: Settings = storage.loadSettings()
        isLogEnabled = settings.logs
    }
}

struct ScriptRowLabelView_Previews: PreviewProvider {
    static var previews: some View {
        ScriptRowLabel(viewModel: ScriptsViewModel(), toggleDetails: {}, script: .constant(DefaultScript))
    }
}
