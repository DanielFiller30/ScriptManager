//
//  ScriptRowView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 05.02.23.
//

import SwiftUI

struct ScriptRowView: View {
    @EnvironmentObject var settings: SettingsHandler
    @StateObject var viewModel: ScriptViewModel
    @State var showDetails: Bool = false
    
    @Binding var script: Script
    
    var body: some View {
        ZStack {
            let value = viewModel.sciptTimes.first(where: {$0.scriptId == script.id})?.progressValue
            ScriptProgressView(height: showDetails ? 0 : 60, value: value ?? 1.0)
            
            DisclosureGroup(isExpanded: $showDetails) {
                VStack {
                    ScriptDetailsView(viewModel: viewModel, script: script)
                }
                .padding(.all, Spacing.l)
                .background(AppColor.Light.opacity(0.5))
                .cornerRadius(10.0)
                .padding(.top, Spacing.l)
            } label: {
                    ScriptRowLabel(
                        viewModel: viewModel,
                        toggleDetails: { showDetails.toggle() },
                        script: script
                    )
            }
            .padding(.all, Spacing.l)
            .background(showDetails ? AppColor.Dark : .clear)
            .cornerRadius(showDetails ? 10.0 : 0)
        }
        .onAppear() {
            viewModel.loadSettings()
        }        
    }
}

struct ScriptRowView_Previews: PreviewProvider {
    static var previews: some View {
        ScriptRowView(viewModel: ScriptViewModel(), script: .constant(DefaultScript))
    }
}
