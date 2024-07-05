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
            let value = vm.scriptHandler.sciptTimes.first(where: {$0.scriptId == script.id})?.progressValue
            if !showDetails {
                ScriptProgressView(height: 60, value: value ?? 1.0, showDetails: $showDetails)
            }
            
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
            .background(showDetails ? AnyShapeStyle(.ultraThickMaterial) : AnyShapeStyle(.clear))
            .overlay(
                RoundedRectangle(cornerRadius: 15.0)
                    .stroke(.white, lineWidth: 1)
            )
            .shadow(radius: 3, x: 1, y: 2)
            .cornerRadius(showDetails ? 10.0 : 0)
        }     
    }
}

struct ScriptRowView_Previews: PreviewProvider {
    static var previews: some View {
        ScriptRowView(showAddScriptModal: .constant(false), script: DefaultScript)
    }
}
