//
//  InfoModal.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 20.07.24.
//

import SwiftUI

struct InfoModalView: View {
    private var vm = InfoViewModel()
    
    var body: some View {
        VStack(alignment: .center) {
            Text("ScriptManager")
                .font(.headline)
                .padding(.bottom, Spacing.m)
            
            Text("scriptmanager-info")
                .multilineTextAlignment(.center)
                .font(.caption)
            
            Divider()
                .padding(.vertical, Spacing.l)
            
            Text("creator")
                .font(.headline)
                .padding(.bottom, Spacing.m)
            
            Text("creator-info")
                .padding(.bottom, Spacing.l)
                .multilineTextAlignment(.center)
                .font(.caption)
            
            Image("bmc_qr")
                .resizable()
                .scaledToFit()
                .frame(height: 100)
            
            Divider()
                .padding(.vertical, Spacing.l)
            
            Spacer()
            
            // Cancel
            CustomButtonView(
                onClick: { vm.modalHandler.hideModal() },
                label: "cancel",
                color: AnyShapeStyle(.ultraThickMaterial),
                outlined: false,
                disabled: false
            )
        }
        .padding()
    }
}

#Preview {
    InfoModalView()
}
