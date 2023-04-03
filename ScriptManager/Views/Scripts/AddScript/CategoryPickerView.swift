//
//  CategoryPickerView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 27.03.23.
//

import SwiftUI

struct CategoryPickerView: View {
    @StateObject var viewModel: ScriptViewModel

    var body: some View {
        Picker("", selection: $viewModel.selectedCategory) {
            ForEach(viewModel.categories) { category in
                Text(category.name)
                    .tag(category.id)
            }
        }
        .onAppear {
            viewModel.loadCategories()
        }
        .frame(width: 145)        
    }
}

struct CategoryPickerView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryPickerView(viewModel: ScriptViewModel())
    }
}
