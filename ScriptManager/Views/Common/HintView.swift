//
//  HintView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 20.07.24.
//

import SwiftUI

public struct HintView: View {
    private var vm = HintViewModel()
    
    var color: Color {
        switch (vm.hintType) {
        case .error: AppColor.Danger
        case .warning: AppColor.Warning
        case .success: AppColor.Success
        }
    }
    
    public init() {}
    
    public var body: some View {
        HStack(alignment: .center) {
            Image(systemName: vm.icon)
                .resizable()
                .scaledToFit()
                .frame(height: 20)
                .foregroundStyle(color)
            
            Spacer()
            
            Text(vm.hintText)
                .font(.headline)
                .multilineTextAlignment(.center)
                .foregroundStyle(.white)
            
            Spacer()
            
            Button {
                vm.hideHint()
            } label: {
                Image(systemName: "xmark")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 12)
                    .foregroundStyle(.white)
            }
            .buttonStyle(.plain)
        }
        .padding(15)
        .background(.ultraThickMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .frame(width: 300)
        .shadow(radius: 3, x:1, y:2)
    }
}

#Preview {
    HintView()
}
