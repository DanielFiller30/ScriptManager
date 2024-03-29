//
//  ScriptsListView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 03.02.23.
//

import SwiftUI

struct ScriptsListView: View {
    @StateObject var viewModel: ScriptViewModel
    @ObservedObject var data = DataHandler.shared
    
    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.l) {
            HStack(alignment: .center) {
                Text("saved \(String(data.scripts.count))")
                    .fontWeight(.bold)
                    .font(.system(size: FontSize.subTitle))
                
                Spacer()
                
                MenuSheetView(
                    hint: "add-new-script",
                    sheetTitle: viewModel.editMode ? "edit-script-title" : "add-new-script",
                    onClick: {
                        viewModel.editMode = false
                        viewModel.showAddScript.toggle()
                    },
                    onClose: viewModel.editMode ? { viewModel.closeEdit() } : {},
                    isPresented: $viewModel.showAddScript,
                    height: 480
                ) {
                    ScriptFormView(viewModel: viewModel)
                }
            }
            .padding(.bottom, Spacing.l)
            
            if (viewModel.dataHandler.scripts.isEmpty) {
                Text("empty-scripts")
                    .font(.system(size: FontSize.text))
                    .foregroundColor(AppColor.Creme)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                
                Spacer()
            } else {
                ScrollView {
                    ForEach($data.scripts) { $script in
                        ScriptRowView(viewModel: viewModel, script: $script)
                            .padding(.horizontal, Spacing.l)
                            .padding(.bottom, Spacing.m)
                    }
                    
                    Spacer()
                }
            }
        }
        .padding(.horizontal, Spacing.xl)
        .padding(.top, Spacing.m)
    }
}

struct ScriptsListView_Previews: PreviewProvider {
    static var previews: some View {
        ScriptsListView(viewModel: ScriptViewModel())
    }
}
