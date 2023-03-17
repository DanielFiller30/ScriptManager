//
//  DeleteChangesButtonView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 21.02.23.
//

import SwiftUI

struct DeleteChangesButton: View {
    @StateObject var viewModel: ScriptsViewModel

    var body: some View {
        Button {
            viewModel.closeEdit()
        } label: {
            HStack(alignment: .center) {
                Text("edit-delete")
                    .padding(.trailing, Spacing.m)
                    .foregroundColor(.white)
                
                Image(systemName: "trash")
                    .resizable()
                    .frame(width: IconSize.m, height: IconSize.m)
                    .foregroundColor(Color.white)
            }
            .padding(.vertical, Spacing.l)
            .padding(.horizontal, Spacing.xl)
            .background(AppColor.Background)
            .clipShape(RoundedRectangle(cornerRadius: 10.0))
            
        }
        .buttonStyle(.plain)
    }
}

struct DeleteChangesButtonView_Previews: PreviewProvider {
    static var previews: some View {
        DeleteChangesButton(viewModel: ScriptsViewModel())
    }
}
