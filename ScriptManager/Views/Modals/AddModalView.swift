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
                Image("Icon_add")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 80)
                    .padding(.bottom, Spacing.l)
                
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
                        
                        Image(systemName: "applescript")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(AppColor.Primary)
                            .frame(height: IconSize.m)
                    }
                    .frame(width: 250)
                    .padding(.horizontal, Spacing.l)
                    .padding(.vertical, Spacing.l)
                    .background(.ultraThinMaterial)
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
                        
                        Image(systemName: "tag")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(AppColor.Primary)
                            .frame(height: IconSize.m)
                    }
                    .frame(width: 250)
                    .padding(.horizontal, Spacing.l)
                    .padding(.vertical, Spacing.l)
                    .background(.ultraThinMaterial)
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
