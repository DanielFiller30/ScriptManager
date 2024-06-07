//
//  TagPickerView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 27.03.23.
//

import Resolver
import SwiftUI

struct TagPickerView: View {
    @Injected private var tagHandler: TagHandlerProtocol
    @State private var vm = ScriptViewModel()

    var body: some View {
        Picker("", selection: $vm.scriptHandler.editScript.tagID) {
            // Add empty default selection
            Text(EmptyTag.name)
                .tag(EmptyTag.id)
            
            ForEach(tagHandler.tags) { tag in
                Text(tag.name)
                    .tag(tag.id)
            }
        }
        .frame(width: 145)  
    }
}

struct TagPickerView_Previews: PreviewProvider {
    static var previews: some View {
        TagPickerView()
    }
}
