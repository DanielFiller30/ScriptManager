//
//  HeaderView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 03.02.23.
//

import SwiftUI

struct HeaderView: View {
    @State private var vm = SettingsViewModel()
    
    var body: some View {
        HStack(alignment: .center) {
            Image("Logo")
                .resizable()
                .scaledToFit()
                .frame(height: 25.0)
                .padding(.trailing, Spacing.m)
            
            Text("Script Manager")
                .fontWeight(.bold)
            
            Text("v4")
                .fontWeight(.light)
            
            Spacer()
            
            Button {
                vm.modalHandler.showSettingsModal()
            } label: {
                Image(systemName: "gear")
                    .resizable()
                    .frame(width: IconSize.l, height: IconSize.l)
                    .padding(Spacing.m)
                    .background(AppColor.Light)
                    .clipShape(Circle())
                    .shadow(radius: 3, x: 1, y: 2)
            }
            .buttonStyle(.plain)
            
            Button {
                vm.showCloseAlert()
            } label: {
                Image(systemName: "xmark.circle")
                    .resizable()
                    .frame(width: IconSize.l, height: IconSize.l)
                    .padding(Spacing.m)
                    .background(AppColor.Light)
                    .clipShape(Circle())
                    .shadow(radius: 3, x: 1, y: 2)
            }
            .buttonStyle(.plain)
        }
        .padding(.vertical, 15)
        .padding(.horizontal, Spacing.xl)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
