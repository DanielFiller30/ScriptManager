//
//  SearchbarView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 19.07.24.
//

import Resolver
import SwiftUI

struct SearchbarView: View {
    @Binding var vm: ScriptViewModel
    @Binding var show: Bool
    
    var body: some View {
        if show {
            HStack(alignment: .center) {
                TextField("search-script-name", text: $vm.searchString)
                    .onChange(of: vm.searchString) {
                        vm.searchForScript()
                    }
                    .textFieldStyle(.plain)
                
                Button {
                    withAnimation {
                        show.toggle()
                    }
                } label: {
                    Image(systemName: "chevron.right")
                }
                .buttonStyle(.plain)
            }
            .frame(maxWidth: 200)
            .padding(.vertical, 6.5)
            .padding(.trailing, 7)
            .padding(.leading, 10)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .shadow(radius: 3, x: 1, y: 2)
            
        } else {
            Button {
                withAnimation {
                    show.toggle()
                }
            } label: {
                Image(systemName: "magnifyingglass")
                    .padding(7)
                    .background(.ultraThinMaterial)
                    .clipShape(Circle())
                    .shadow(radius: 3, x: 1, y: 2)
            }
            .buttonStyle(.plain)
        }
    }
}

struct SearchbarView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            SearchbarView(vm: .constant(ScriptViewModel()), show: .constant(false))
        }
        .padding()
        .background(.gray)
    }
}
