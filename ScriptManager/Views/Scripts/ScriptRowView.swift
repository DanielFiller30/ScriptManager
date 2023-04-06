//
//  ScriptRowView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 05.02.23.
//

import SwiftUI

struct ScriptRowView: View {
    @StateObject var viewModel: ScriptViewModel
    
    @Binding var script: Script
    
    @State var showDetails: Bool = false
    @State var isRunning: Bool = false
    
    var body: some View {
        DisclosureGroup(isExpanded: $showDetails) {
            Divider()
                .padding(.top, Spacing.l)
            
            ScriptDetailsView(viewModel: viewModel, script: script, isRunning: isRunning)
            
        } label: {
            ScriptRowLabel(
                viewModel: viewModel,
                toggleDetails: { showDetails.toggle() },
                script: $script,
                isRunning: $isRunning
            )
        }
        .padding(.all, Spacing.l)
        .background(AppColor.Dark)
        .cornerRadius(10)
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
