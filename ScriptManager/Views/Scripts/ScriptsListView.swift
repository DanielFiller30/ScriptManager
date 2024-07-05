//
//  ScriptsListView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 03.02.23.
//

import SwiftUI

struct ScriptsListView: View {
    @State private var vm = ScriptViewModel()
    @State private var showAddScriptModal = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.l) {
            HStack(alignment: .center) {
                Text("saved \(String(vm.scripts.count))")
                    .fontWeight(.bold)
                    .font(.system(size: FontSize.subTitle))
                
                Spacer()
                
                Button {
                    vm.scriptHandler.editScript = EmptyScript
                    vm.modalHandler.showAddScriptModal()
                } label: {
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: IconSize.s, height: IconSize.s)
                        .foregroundColor(Color.white)
                        .help("add-new-tag")
                }
                .buttonStyle(.plain)
            }
            .padding(.bottom, Spacing.l)
            
            if (vm.scripts.isEmpty) {
                Text("empty-scripts")
                    .font(.system(size: FontSize.text))
                    .foregroundColor(AppColor.Creme)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                
                Spacer()
            } else {
                ScrollView {
                    ForEach(vm.scripts) { script in
                        ScriptRowView(showAddScriptModal: $showAddScriptModal, script: script)
                            .padding(.horizontal, Spacing.l)
                            .padding(.bottom, Spacing.m)
                    }
                    
                    Spacer()
                }
            }
        }
        .padding(.horizontal, Spacing.xl + 4)
        .padding(.top, Spacing.m)
    }
}

struct ScriptsListView_Previews: PreviewProvider {
    static var previews: some View {
        ScriptsListView()
    }
}
