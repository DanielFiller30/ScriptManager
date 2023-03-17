//
//  WelcomeView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 10.02.23.
//

import SwiftUI

struct WelcomeView: View {
    let close: () -> Void
    @Binding var hideWelcomeScreen: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                Image("Icon")
                
                Spacer()
                
                Text("welcome-title")
                    .font(.system(size: FontSize.title))
                    .fontWeight(.bold)
                
                Spacer()
            }
            .padding(.bottom, Spacing.xl)
            
            Text("welcome-info")
                .font(.system(size: FontSize.text))
                .padding(.bottom, Spacing.s)
            
            HStack(alignment: .center) {
                Text("welcome-info2")
                    .font(.system(size: FontSize.text))
                
                Image(systemName: "gear")
                    .resizable()
                    .frame(width: IconSize.l, height: IconSize.l)
                    .padding(Spacing.m)
                    .background(AppColor.Light)
                    .clipShape(Circle())
                
            }
            
            Text("welcome-info3")
                .font(.system(size: FontSize.text))
            
            HStack(alignment: .center) {
                Text("welcome-info4")
                    .font(.system(size: FontSize.text))
                
                Image(systemName: "checkmark")
                    .foregroundColor(AppColor.Success)
                    .frame(width: IconSize.s, height: IconSize.s)
                    .padding(Spacing.l)
                    .background(AppColor.Background)
                    .clipShape(Circle())
                
                Image(systemName: "xmark")
                    .foregroundColor(AppColor.Danger)
                    .frame(width: IconSize.s, height: IconSize.s)
                    .padding(Spacing.l)
                    .background(AppColor.Background)
                    .clipShape(Circle())
                
                Image(systemName: "xmark")
                    .foregroundColor(AppColor.Dark)
                    .frame(width: IconSize.s, height: IconSize.s)
                    .padding(Spacing.l)
                    .background(AppColor.Danger)
                    .clipShape(Circle())
            }
            
            Text("welcome-info5")
                .font(.system(size: FontSize.text))
            
            Spacer()
            
            HStack(alignment: .center) {
                Text("welcome-toggle")
                    .font(.system(size: FontSize.text))
                
                Toggle("", isOn: $hideWelcomeScreen)
                
                Spacer()
                
                Button {
                    close()
                } label: {
                    HStack(alignment: .center) {
                        Text("welcome-close")
                            .padding(.trailing, Spacing.l)
                        
                        Image(systemName: "xmark")
                            .resizable()
                            .frame(width: IconSize.m, height: IconSize.m)
                            .foregroundColor(AppColor.Creme)
                        
                    }
                    .padding(Spacing.l)
                    .background(AppColor.Dark)
                    .clipShape(RoundedRectangle(cornerRadius: 10.0))
                    
                }
                .buttonStyle(.plain)
            }
            
        }
        .frame(width: 500, height: 420)
        .padding(Spacing.xl)
        
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView(close: {}, hideWelcomeScreen: .constant(false))
    }
}
