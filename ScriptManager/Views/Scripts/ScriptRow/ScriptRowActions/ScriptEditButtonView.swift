//
//  ScriptEditButtonView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 20.02.23.
//

import SwiftUI

struct ScriptEditButtonView: View {
    var viewModel: ScriptsViewModel
    var script: Script
    
    var body: some View {
        Button {
            viewModel.openEdit(script: script)
        } label: {
            HStack(alignment: .center) {
                Text("edit-script")
                    .padding(.trailing, Spacing.m)
                    .foregroundColor(.white)
                
                Image(systemName: "pencil")
                    .resizable()
                    .frame(width: IconSize.m, height: IconSize.m)
                    .foregroundColor(Color.white)
            }
            .padding(Spacing.l)
            .background(AppColor.Background)
            .clipShape(RoundedRectangle(cornerRadius: 10.0))
            
        }
        .buttonStyle(.plain)
        
    }
}

struct ScriptEditButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ScriptEditButtonView(viewModel: ScriptsViewModel(), script: DefaultScript)
    }
}
