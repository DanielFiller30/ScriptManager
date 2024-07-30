//
//  HeaderView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 03.02.23.
//

import SwiftUI

struct HeaderView: View {
    @State private var vm = HeaderViewModel()
    
    var body: some View {
        HStack(alignment: .center) {
            Image("Logo")
                .resizable()
                .scaledToFit()
                .frame(height: 20.0)
                .padding(.trailing, Spacing.m)
            
            Text("Script Manager")
                .fontWeight(.bold)
            
            Text("v4")
                .fontWeight(.light)
            
            Spacer()
            
            if vm.selectedTag != nil {
                Button {
                    vm.showDeleteTagAlert()
                } label: {
                    HStack {
                        Image(systemName: "trash")
                            .resizable()
                            .frame(width: IconSize.m, height: IconSize.m)
                    }
                    .frame(width: IconSize.l, height: IconSize.l)
                    .padding(Spacing.m)
                    .background(.ultraThinMaterial)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(vm.getTagColor(), lineWidth: 1)
                    )
                    .shadow(radius: 3, x: 1, y: 2)
                    .help("hint-remove-tag")
                }
                .buttonStyle(.plain)
                .padding(.trailing, Spacing.m)
                
                Button {
                    vm.openEditTag()
                } label: {
                    HStack {
                        Image(systemName: "pencil")
                            .resizable()
                            .frame(width: IconSize.m, height: IconSize.m)
                    }
                    .frame(width: IconSize.l, height: IconSize.l)
                    .padding(Spacing.m)
                    .background(.ultraThinMaterial)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(vm.getTagColor(), lineWidth: 1)
                    )
                    .shadow(radius: 3, x: 1, y: 2)
                    .help("hint-remove-tag")
                }
                .buttonStyle(.plain)
                .padding(.trailing, Spacing.m)
            }
            
            Button {
                vm.modalHandler.showModal(.ADD)
            } label: {
                HStack {
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: IconSize.m, height: IconSize.m)
                }
                .frame(width: IconSize.l, height: IconSize.l)
                .padding(Spacing.m)
                .background(.ultraThinMaterial)
                .clipShape(Circle())
                .shadow(radius: 3, x: 1, y: 2)
            }
            .buttonStyle(.plain)
            .padding(.trailing, Spacing.m)
            
            Button {
                vm.modalHandler.showModal(.SETTINGS)
            } label: {
                Image(systemName: "gear")
                    .resizable()
                    .frame(width: IconSize.l, height: IconSize.l)
                    .padding(Spacing.m)
                    .background(.ultraThinMaterial)
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
