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
                .fontWeight(.bold)
                .font(.system(size: FontSize.subTitle))
                .padding(.bottom, Spacing.l)
            
            if (viewModel.scripts.isEmpty) {
                Text("empty-scripts")
                    .font(.system(size: FontSize.text))
                    .foregroundColor(Color.Creme)
                    .padding()
                    .multilineTextAlignment(.center)
                
            } else {
                ScrollView {
                    ForEach($viewModel.scripts) { $script in
                        ScriptRowView(viewModel: viewModel, script: script)
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

struct ScriptsListView_Previews: PreviewProvider {
    static var previews: some View {
        ScriptsListView(viewModel: ScriptsViewModel())
    }
}
