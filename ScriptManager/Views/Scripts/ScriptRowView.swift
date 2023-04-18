//
//  ScriptRowView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 05.02.23.
//

import SwiftUI

struct ScriptRowView: View {
    @StateObject var viewModel: ScriptViewModel
    @State var showDetails: Bool = false
    
    @Binding var script: Script
    
    var body: some View {
        DisclosureGroup(isExpanded: $showDetails) {
            Divider()
                .padding(.top, Spacing.l)
            
            ScriptDetailsView(viewModel: viewModel, script: script)
            
        } label: {
            ScriptRowLabel(
                viewModel: viewModel,
                toggleDetails: { showDetails.toggle() },
                script: script
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
