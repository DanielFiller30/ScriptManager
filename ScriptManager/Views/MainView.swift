//
//  MainView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 03.02.23.
//

import SwiftUI

struct MainView: View {
    @StateObject private var vmScript = ScriptViewModel()
    @StateObject private var vmTag = TagViewModel()
    
    @StateObject private var settings = SettingsHandler()
    
    var body: some View {
        VStack(spacing: Spacing.zero) {
            HeaderView()
                .background(
                    LinearGradient(colors: [AppColor.Header, AppColor.AppBg], startPoint: .top, endPoint: .bottom)
                )

            
            Divider()
                .frame(minHeight: 2)
                .background(AppColor.Header)
                .foregroundColor(AppColor.AppBg)
            
            TagsListView(vmTag: vmTag, vmScript: vmScript)
                .background(AppColor.AppBg)

    
            Divider()
                .frame(minHeight: 2)
                .background(AppColor.Header)
                .foregroundColor(AppColor.AppBg)
               
            
            ScriptsListView(viewModel: vmScript)
                .padding(.top, Spacing.xl)
                .background(AppColor.AppBg)

        }
        .frame(width: 380, height: 550)
        .environmentObject(settings)
        .onAppear {
            vmScript.loadScriptTimes()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
