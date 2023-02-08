//
//  ScriptDetailsView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 05.02.23.
//

import SwiftUI

struct ScriptDetailsView: View {
    var viewModel = ScriptsViewModel()
    var script: Script
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                Text("path")
                    .font(.system(size: 11))
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .frame(width: 80, alignment: .leading)
                
                Spacer()
                
                Text(script.path)
                    .font(.system(size: 11))
                    .foregroundColor(Color.white)
                    .onTapGesture() {
                        let pasteboard = NSPasteboard.general
                        pasteboard.clearContents()
                        pasteboard.setString(script.path, forType: .string)
                    }
            }
            .padding(.bottom, Spacing.m)
            
            HStack(alignment: .top) {
                Text("last-run")
                    .font(.system(size: 11))
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .frame(width: 80, alignment: .leading)

                Spacer()
                
                if (script.lastRun != nil) {
                    Text(viewModel.getFormattedDate(date: script.lastRun!))
                        .font(.system(size: 11))
                        .foregroundColor(Color.white)
                } else {
                    Text("-")
                        .font(.system(size: 11))
                        .foregroundColor(Color.white)
                }
            }
        }
        .padding(.all, Spacing.m)
    }
}
