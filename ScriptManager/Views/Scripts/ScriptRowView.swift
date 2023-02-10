//
//  ScriptsListRowView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 05.02.23.
//

import SwiftUI

struct ScriptRowView: View {
    @StateObject var viewModel: ScriptsViewModel
    
    @State var script: Script
    @State var showDetails: Bool = false

    var body: some View {
        DisclosureGroup(isExpanded: $showDetails) {
            Divider()
                .padding(.top, Spacing.l)
            
            ScriptDetailsView(script: script)
            
        } label: {
            ScriptRowLabel(
                viewModel: viewModel,
                toggleDetails: { showDetails.toggle() },
                script: $script
            )
            
        }
        .padding(.all, Spacing.l)
        .frame(maxWidth: 350, alignment: .leading)
        .background(Color.Dark)
        .cornerRadius(10)
    }
}
