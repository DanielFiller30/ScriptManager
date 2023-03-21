//
//  SaveChangesButtonView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 21.02.23.
//

import SwiftUI

struct SaveChangesButton: View {
    @StateObject var viewModel: ScriptViewModel

    var body: some View {
        Button {
            viewModel.updateScript()
        } label: {
            HStack(alignment: .center) {
                Text("edit-save")
                    .padding(.trailing, Spacing.m)
                    .foregroundColor(.white)
                
                Image(systemName: "pencil")
                    .resizable()
                    .frame(width: IconSize.m, height: IconSize.m)
                    .foregroundColor(Color.white)
            }
            .padding(.vertical, Spacing.l)
            .padding(.horizontal, Spacing.xl)
            .background(AppColor.Success)
            .clipShape(RoundedRectangle(cornerRadius: 10.0))
            
        }
        .buttonStyle(.plain)    }
}

struct SaveChangesButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SaveChangesButton(viewModel: ScriptViewModel())
    }
}
