//
//  ScriptLogButtonView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 20.02.23.
//

import SwiftUI

struct ScriptLogButtonView: View {
    let viewModel: ScriptViewModel
    
    var body: some View {
        Button {
            viewModel.openLogs()
        } label: {
            HStack(alignment: .center) {
                Text("open-logs")
                    .padding(.trailing, Spacing.m)
                    .foregroundColor(.white)
                
                Image(systemName: "folder")
                    .resizable()
                    .frame(width: IconSize.m, height: IconSize.m)
                    .foregroundColor(Color.white)
            }
            .padding(Spacing.l)
            .background(AppColor.Background)
            .clipShape(RoundedRectangle(cornerRadius: 10.0))
            
        }
        .disabled(!viewModel.isLogEnabled)
        .buttonStyle(.plain)
        
    }
}

struct ScriptLogButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ScriptLogButtonView(viewModel: ScriptViewModel())
    }
}
