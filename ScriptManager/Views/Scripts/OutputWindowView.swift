//
//  OutputWindowView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 03.04.23.
//

import Resolver
import SwiftUI
import AlertToast

struct OutputWindowView: View {
    @Injected private var scriptHandler: ScriptHandlerProtocol
    
    @State private var showToast = false
    
    var script: Script
    var window: NSWindow
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(script.name)
                    .font(.title2)
                
                Spacer()
                
                if let time = scriptHandler.scripts.first(where: { $0.id == script.id })?.time?.remainingTime {
                    Text(time)
                        .font(.caption2)
                        .padding(Spacing.l)
                        .cornerRadius(10.0)
                }
            }
            
            Divider()
                .padding(.vertical, Spacing.l)
            
            Text("command")
                .font(.headline)
            
            HStack {
                Text(script.command)
                    .font(.caption)
                
                Spacer()
            }
            .padding()
            .background(.ultraThickMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(radius: 3, x: 1, y: 2)
            .padding(.bottom, Spacing.xxl)
            
            Text("output")
                .font(.headline)
            
            ScrollView {
                HStack {
                    VStack(alignment: .leading) {
                        Text(scriptHandler.scripts.first(where: { $0.id == script.id })?.output ?? "")
                            .multilineTextAlignment(.leading)
                            .padding(.bottom, Spacing.l)
                    }
                    
                    Spacer()
                }
            }
            .padding()
            .background(.ultraThickMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(radius: 3, x: 1, y: 2)
            .padding(.bottom, Spacing.xxl)
            
            Text("errors")
                .font(.headline)
            
            ScrollView {
                HStack {
                    VStack(alignment: .leading) {
                        Text(scriptHandler.scripts.first(where: { $0.id == script.id })?.error ?? "")
                            .foregroundStyle(AppColor.Danger)
                            .multilineTextAlignment(.leading)
                            .padding(.bottom, Spacing.l)
                    }
                    
                    Spacer()
                }
            }
            .padding()
            .background(.ultraThickMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(radius: 3, x: 1, y: 2)
            .padding(.bottom, Spacing.xxl)
            
            HStack(spacing: Spacing.l) {
                Spacer()
                
                Button {
                    // Copy path
                    let pasteboard = NSPasteboard.general
                    pasteboard.clearContents()
                    pasteboard.setString(scriptHandler.scripts.first(where: { $0.id == script.id })?.error ?? "", forType: .string)
                    
                    // Show 'copied' toast
                    showToast.toggle()
                } label: {
                    HStack(alignment: .center) {
                        Text("copy-error")
                        
                        Image(systemName: "clipboard.fill")
                    }
                    .padding(.horizontal)
                    .padding(.vertical, Spacing.l)
                    .background(.ultraThickMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(radius: 3, x: 1, y: 2)
                }
                .buttonStyle(.plain)
                
                Button {
                    window.close()
                } label: {
                    HStack(alignment: .center) {
                        Text("close-window")
                        
                        Image(systemName: "xmark")
                    }
                    .padding(.horizontal)
                    .padding(.vertical, Spacing.l)
                    .background(AppColor.Primary)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(radius: 3, x: 1, y: 2)
                }
                .buttonStyle(.plain)
            }
        }
        .toast(isPresenting: $showToast, duration: 1, tapToDismiss: true) {
            AlertToast(type: .regular, title: String(localized: "hint-copied"))
        }
        .padding(Spacing.xl)
        .frame(minWidth: 500, minHeight: 500)
    }
}

struct OutputWindowView_Previews: PreviewProvider {
    static var previews: some View {
        OutputWindowView(script: DefaultScript, window: NSWindow())
    }
}
