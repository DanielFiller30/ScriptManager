//
//  OutputWindowView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 03.04.23.
//

import SwiftUI

struct OutputWindowView: View {
    @StateObject var scriptHandler: ScriptHandler
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(scriptHandler.output)
                    .multilineTextAlignment(.leading)
            }
        }
        .padding(Spacing.l)
        .frame(minWidth: 500, minHeight: 600)
    }
}

struct OutputWindowView_Previews: PreviewProvider {
    static var previews: some View {
        OutputWindowView(scriptHandler: ScriptHandler())
    }
}
