//
//  OutputWindowView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 03.04.23.
//

import Resolver
import SwiftUI

struct OutputWindowView: View {
    @Injected private var scriptHandler: ScriptHandlerProtocol

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(scriptHandler.output)
                    .multilineTextAlignment(.leading)
                    .padding(.bottom, Spacing.l)
                
                Text(scriptHandler.error)
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(AppColor.Danger)
            }
        }
        .padding(Spacing.l)
        .frame(minWidth: 500, minHeight: 600)
    }
}

struct OutputWindowView_Previews: PreviewProvider {
    static var previews: some View {
        OutputWindowView()
    }
}
