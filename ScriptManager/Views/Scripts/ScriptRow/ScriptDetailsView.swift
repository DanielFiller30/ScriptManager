//
//  ScriptDetailsView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 05.02.23.
//

import SwiftUI

struct ScriptDetailsView: View {
    var viewModel: ScriptViewModel
    let scriptHandler: ScriptHandler = ScriptHandler()
    // TODO: CHECK BINDING
    var script: Script
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                Text("path")
                    .font(.system(size: FontSize.text))
                    .fontWeight(.bold)
                    .frame(width: 80, alignment: .leading)
                
                Spacer()
                
                Text(script.command)
                    .font(.system(size: FontSize.text))
                    .onTapGesture() {
                        // Copy path
                        let pasteboard = NSPasteboard.general
                        pasteboard.clearContents()
                        pasteboard.setString(script.command, forType: .string)
                    }
            }
            .padding(.bottom, Spacing.m)
            
            HStack(alignment: .top) {
                Text("last-run")
                    .font(.system(size: FontSize.text))
                    .fontWeight(.bold)
                    .frame(width: 80, alignment: .leading)
                
                Spacer()
                
                if (script.lastRun != nil) {
                    Text(scriptHandler.getFormattedDate(date: script.lastRun!))
                        .font(.system(size: FontSize.text))
                } else {
                    Text("-")
                        .font(.system(size: FontSize.text))
                }
            }
            
            Divider()
            
            HStack(alignment: .center) {
                ScriptLogButtonView(viewModel: viewModel)
                
                Spacer()
                
                ScriptEditButtonView(viewModel: viewModel, script: script)
            }
            .padding(.all, Spacing.m)
        }
        .padding(.all, Spacing.m)
    }
}

struct ScriptDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ScriptDetailsView(viewModel: ScriptViewModel(), script: DefaultScript)
    }
}
