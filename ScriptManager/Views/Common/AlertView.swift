//
//  AlertView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 17.05.24.
//

import SwiftUI
import Resolver

struct AlertView: View {
    @State private var vm = AlertViewModel()
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.5)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text(vm.title)
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 5)
                
                Text(vm.message)
                    .font(.caption)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 15)
                
                Button {
                    vm.action()
                } label: {
                    HStack {
                        Spacer()
                        Text(vm.btnTitle)
                            .font(.callout)
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .buttonStyle(.plain)
                .padding(.bottom, 3)
                
                if vm.cancelVisible {
                    Button {
                        vm.hideAlert()
                    } label: {
                        HStack {
                            Spacer()
                            Text("close-alert")
                                .font(.callout)
                            Spacer()
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                        .background(AppColor.Light)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    .buttonStyle(.plain)
                    .padding(.top, 3)
                }                
            }
            .padding(25)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .shadow(color: .black, radius: 4, x: 2, y: 4)
            .frame(width: 300)
        }
    }
}

#Preview {
    AlertView()
}
