//
//  AddModalView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 05.07.24.
//

import Resolver
import SwiftUI

struct AddModalView: View {
    @State private var vm = ModalViewModel()
    
    var body: some View {
        HStack {
            Spacer()
            
            VStack(alignment: .center) {
                if #available(macOS 15.0, *) {
                    Image(systemName: "doc.badge.plus")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 30)
                        .padding(.bottom, Spacing.l)
                        .symbolEffect(.bounce, options: .nonRepeating)
                } else {
                    // Fallback on earlier versions
                    Image(systemName: "doc.badge.plus")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 30)
                        .padding(.bottom, Spacing.l)
                }
                
                Button {
                    vm.modalHandler.hideModal()
                    vm.modalHandler.showModal(.ADD_SCRIPT)
                } label: {
                    HStack(alignment: .center) {
                        Spacer()
                        
                        Text("add-new-script")
                            .font(.system(size: FontSize.text))
                            .bold()
                        
                        Spacer()
                    }
                    .frame(width: 250)
                    .padding()
                    .background(.ultraThickMaterial)
                    .cornerRadius(8)
                    .shadow(radius: 3, x: 1, y: 2)
                }
                .buttonStyle(.plain)
                
                Text("add-script-info")
                    .font(.footnote)
                    .foregroundStyle(AppColor.Creme)
                    .padding(.bottom, Spacing.xl)
                    .padding(.top, Spacing.m)
                    .padding(.horizontal, Spacing.m)
                    .multilineTextAlignment(.center)
                
                if #available(macOS 15.0, *) {
                    Image(systemName: "tag")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 30)
                        .padding(.bottom, Spacing.l)
                        .symbolEffect(.bounce, options: .nonRepeating)
                } else {
                    // Fallback on earlier versions
                    Image(systemName: "tag")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 30)
                        .padding(.bottom, Spacing.l)
                }
                
                Button {
                    vm.modalHandler.hideModal()
                    vm.modalHandler.showModal(.TAG)
                } label: {
                    HStack(alignment: .center) {
                        Spacer()
                        
                        Text("add-new-tag")
                            .font(.system(size: FontSize.text))
                            .bold()
                        
                        Spacer()
                    }
                    .frame(width: 250)
                    .padding()
                    .background(.ultraThickMaterial)
                    .cornerRadius(8)
                    .shadow(radius: 3, x: 1, y: 2)
                }
                .buttonStyle(.plain)
                
                Text("add-tag-info")
                    .font(.footnote)
                    .foregroundStyle(AppColor.Creme)
                    .padding(.bottom, Spacing.xl)
                    .padding(.top, Spacing.m)
                    .padding(.horizontal, Spacing.m)
                    .multilineTextAlignment(.center)
            }
            
            Spacer()
        }
    }
}

struct AddModalView_Previews: PreviewProvider {
    static var previews: some View {
        AddModalView()
    }
}
