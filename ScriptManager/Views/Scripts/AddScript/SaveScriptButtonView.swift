//
//  SaveScriptButtonView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 10.02.23.
//

import SwiftUI

struct SaveScriptButtonView: View {
    @StateObject var viewModel: ScriptsViewModel
    
    @Binding var testIsRunning: Bool
    
    var body: some View {
        Button {
            saveScript()
        } label: {
            HStack(alignment: .center) {
                Text("save-script")
                    .padding(.trailing, Spacing.m)
                    .foregroundColor(.white)
                
                Image(systemName: "doc.badge.plus")
                    .resizable()
                    .frame(width: IconSize.m, height: IconSize.m)
                    .foregroundColor(Color.white)
            }
            .padding(Spacing.l)
            .background(Color.Success)
            .clipShape(RoundedRectangle(cornerRadius: 10.0))
            
        }
        .buttonStyle(.plain)
        .disabled(testIsRunning || viewModel.name.isEmpty || viewModel.command.isEmpty)
        
    }
    
    func saveScript() {
        viewModel.saveScript()
        viewModel.showAddScript.toggle()
    }
}

struct SaveScriptButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SaveScriptButtonView(viewModel: ScriptsViewModel(), testIsRunning: .constant(false))
    }
}
