//
//  ScriptDetailsView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 05.02.23.
//

import SwiftUI

struct ScriptDetailsView: View {
    var viewModel = ScriptsViewModel()
    let scriptHandler: ScriptHandler = ScriptHandler()
    var script: Script
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                Text("path")
                    .font(.system(size: FontSize.text))
                    .fontWeight(.bold)
                    .frame(width: 80, alignment: .leading)
                
                Spacer()
                
                Text(script.path)
                    .font(.system(size: FontSize.text))
                    .onTapGesture() {
                        // Copy path
                        let pasteboard = NSPasteboard.general
                        pasteboard.clearContents()
                        pasteboard.setString(script.path, forType: .string)
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
        }
        .padding(.all, Spacing.m)
    }
}

struct ScriptDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ScriptDetailsView(viewModel: ScriptsViewModel(), script: DefaultScript)
    }
}
