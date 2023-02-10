//
//  ScriptDeleteButtonView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 10.02.23.
//

import SwiftUI

struct ScriptDeleteButtonView: View {
    let viewModel: ScriptsViewModel
    @Binding var scriptId: UUID
    @Binding var isRunning: Bool
    
    @State var showDeleteAlert: Bool = false
    
    var body: some View {
        Button {
            showDeleteAlert.toggle()
        } label: {
            Image(systemName: "trash")
                .resizable()
                .frame(width: IconSize.s, height: IconSize.s)
                .padding(Spacing.l)
                .background(Color.Background)
                .clipShape(Circle())
        }
        .buttonStyle(.plain)
        .disabled(isRunning)
        .alert(String(localized: "delete-title"), isPresented: $showDeleteAlert) {
            
            Button("cancel", role: .cancel) {}
            Button("delete") {
                viewModel.deleteScript(id: scriptId)
            }
            
        } message: {
            Text("delete-msg")
        }
    }
}

struct ScriptDeleteButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ScriptDeleteButtonView(viewModel: ScriptsViewModel(), scriptId: .constant(UUID()), isRunning: .constant(false))
    }
}
