//
//  ScriptDetailView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 05.02.23.
//

import SwiftUI

struct ScriptDetailView: View {
    var path: String
    
    var body: some View {
        Text(path)
    }
}

struct ScriptDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ScriptDetailView(path: "Test123")
    }
}
