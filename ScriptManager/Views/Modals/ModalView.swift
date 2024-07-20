//
//  ModalView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 07.06.24.
//

import SwiftUI

struct ModalView: View {
    @State private var vm = ModalViewModel()
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.5)
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    
                    Text(vm.modalTitle)
                        .font(.system(size: FontSize.title))
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    Button {
                        vm.modalHandler.hideModal()
                    } label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .frame(width: IconSize.s, height: IconSize.s)
                    }
                    .buttonStyle(.plain)
                }
                .padding(.bottom, Spacing.xl)
                
                switch vm.modalType {
                case .TAG:
                    TagModalView()
                case .SETTINGS:
                    SettingsModalView()
                case .INFO:
                    InfoModalView()
                case .ADD_SCRIPT, .EDIT_SCRIPT:
                    ScriptModalView()
                case .ADD:
                    AddModalView()
                }
            }
            .padding(.all, Spacing.xl)
            .background(.ultraThinMaterial)
            .cornerRadius(15.0)
            .shadow(color: .black, radius: 4, x: 2, y: 4)
            .padding(Spacing.xl)
        }
    }
}

#Preview {
    ModalView()
}
