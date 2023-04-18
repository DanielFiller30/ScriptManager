//
//  TagPickerView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 27.03.23.
//

import SwiftUI

struct TagPickerView: View {
    @StateObject var viewModel: ScriptViewModel
    let dataHandler = DataHandler.shared

    var body: some View {
        Picker("", selection: $viewModel.selectedTag) {
            // Add empty default selection
            Text(EmptyTag.name)
                .tag(EmptyTag.id)
            
            ForEach(dataHandler.tags) { tag in
                Text(tag.name)
                    .tag(tag.id)
            }
        }
        .frame(width: 145)        
    }
}

struct TagPickerView_Previews: PreviewProvider {
    static var previews: some View {
        TagPickerView(viewModel: ScriptViewModel())
    }
}
