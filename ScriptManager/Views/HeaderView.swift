//
//  HeaderView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 03.02.23.
//

import SwiftUI

struct HeaderView: View {
    @EnvironmentObject var settings: ScriptManagerSettings
    
    @State var showCloseAlert: Bool = false
    
    var body: some View {
        HStack(alignment: .center) {
            Image("StatusBarIcon")
                .foregroundColor(settings.mainColor)
            
            Text("Script Manager")
                .font(Font.custom("Courier New", size: FontSize.title))
                .fontWeight(.bold)
            
            Spacer()
            
            Button {
                settings.showingPopover.toggle()
            } label: {
                Image(systemName: "gear")
                    .resizable()
                    .frame(width: IconSize.l, height: IconSize.l)
                    .padding(Spacing.m)
                    .background(AppColor.Light)
                    .clipShape(Circle())
            }
            .buttonStyle(.plain)
            .popover(isPresented: $settings.showingPopover) {
                SettingsView()
            }
            
            Button {
                showCloseAlert.toggle()
            } label: {
                Image(systemName: "xmark.circle")
                    .resizable()
                    .frame(width: IconSize.l, height: IconSize.l)
                    .padding(Spacing.m)
                    .background(AppColor.Light)
                    .clipShape(Circle())
            }
            .buttonStyle(.plain)
            .alert("close-app-title", isPresented: $showCloseAlert) {
                Button("cancel", role: .cancel) {}
                Button("close-app-btn") {
                    terminateApp()
                }
                
            } message: {
                Text("close-app-msg")
            }
            
        }
        .padding(.vertical, Spacing.l)
        .padding(.horizontal, Spacing.xl)
        .background(AppColor.Dark)
    }
    
    func terminateApp() {
        NSApp.terminate(self)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
