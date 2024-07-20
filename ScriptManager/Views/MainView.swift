//
//  MainView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 03.02.23.
//

import SwiftUI
import ConfettiSwiftUI

struct MainView: View {
    @State private var vm = MainViewModel()
        
    var body: some View {
        ZStack {
            VStack(spacing: Spacing.zero) {
                HeaderView()
                
                Divider()
                    .frame(minHeight: 2)
                    .foregroundColor(AppColor.AppBg)
                
                ScriptsListView()
                    .padding(.top, Spacing.l)
            }
            
            if vm.alertVisible {
                AlertView()
            }
            
            if vm.modalVisible {
                ModalView()
            }
            
            if vm.hintVisible {
                HintView()
                    .position(x: 380 / 2, y: 50)
            }
        }
        .frame(width: 380, height: 550)
        .background(.ultraThinMaterial)
        .confettiCannon(
            counter: $vm.scriptHandler.finishedCounter,
            num: 80,
            colors: [Color(.primary), Color(.secondary)],
            confettiSize: 10,
            radius: 350
        )
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
