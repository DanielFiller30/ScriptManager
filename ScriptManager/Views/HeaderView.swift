//
//  HeaderView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 03.02.23.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        HStack(alignment: .center) {
            Image("StatusBarIcon")
            
            Text("Script Manager")
                .foregroundColor(.white)
                .font(.system(size: 14))
            
            Spacer()
            
            Button {
                print("TEST")
            } label: {
                Image(systemName: "gear")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .padding(5)
                    .background(Color.Light)
                    .clipShape(Circle())
            }
            .buttonStyle(.plain)
            
        }
        .padding(.vertical, Spacing.l)
        .padding(.horizontal, Spacing.xl)
        .background(Color.Dark)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
