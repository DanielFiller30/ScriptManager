//
//  ScriptsListView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 03.02.23.
//

import SwiftUI

struct ScriptsListView: View {
    @StateObject var viewModel: ScriptsViewModel

    var body: some View {
        VStack(alignment: .leading) {
            Text("saved \(String($viewModel.scripts.count))")
                .foregroundColor(.white)
                .fontWeight(.bold)
                .font(.system(size: 12))
                .padding(.bottom, Spacing.m)
            
            if (viewModel.scripts.isEmpty) {
                Text("empty-scripts")
                    .font(.system(size: 11))
                    .foregroundColor(Color.Creme)
                    .padding()
                    .multilineTextAlignment(.center)
                
            } else {
                ScrollView {
                    ForEach($viewModel.scripts) { $script in
                        ScriptsListRowView(viewModel: viewModel, script: script)
                    }
                }
            }
            
        }
        .frame(maxWidth: 350, alignment: .leading)
        .onAppear() {
            viewModel.loadScripts()
        }
    }
}
