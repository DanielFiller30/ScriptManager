//
//  ScriptRowView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 05.02.23.
//

import SwiftUI

struct ScriptRowView: View {
    @State var vm = ScriptViewModel()
    @State var showDetails: Bool = false
    
    @Binding var showAddScriptModal: Bool
    
    var script: Script
        
    var body: some View {
        ZStack {
            DisclosureGroup(isExpanded: $showDetails) {
                VStack {
                    ScriptDetailsView(showAddScriptModal: $showAddScriptModal, script: script)
                }
                .padding(.all, Spacing.l)

            } label: {
                    ScriptRowLabel(
                        toggleDetails: {
                            withAnimation() {
                                showDetails.toggle()
                            }
                        },
                        script: script
                    )
            }
            .padding(.all, Spacing.l)
            .background(.ultraThickMaterial)
            .cornerRadius(15)
            .shadow(radius: 3, x: 1, y: 2)
        }
    }
}

struct ScriptRowView_Previews: PreviewProvider {
    static var previews: some View {
        ScriptRowView(showAddScriptModal: .constant(false), script: DefaultScript)
    }
}
