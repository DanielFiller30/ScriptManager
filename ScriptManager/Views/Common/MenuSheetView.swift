////
////  TabButtonView.swift
////  ScriptManager
////
////  Created by Filler, Daniel on 28.03.23.
////
//
//import SwiftUI
//
//struct MenuSheetView: View {
//    let hint: LocalizedStringKey
//    let onClick: () -> Void
//    let onClose: () -> Void
//    let height: CGFloat
//    
//    let width: CGFloat = 350.0
//    
//    @Binding var isPresented: Bool
//    
//    init(
//        hint: LocalizedStringKey,
//        sheetTitle: LocalizedStringKey,
//        onClick: @escaping () -> Void,
//        onClose: @escaping () -> Void,
//        isPresented: Binding<Bool>,
//        height: CGFloat
//    ) {
//        self.hint = hint
//        self.onClick = onClick
//        self.onClose = onClose
//        self.height = height
//        
//        self._isPresented = isPresented
//    }
//    
//    var body: some View {
//        Button {
//            withAnimation {
//                onClick()
//            }
//        } label: {
//            Image(systemName: "plus")
//                .resizable()
//                .frame(width: IconSize.s, height: IconSize.s)
//                .foregroundColor(Color.white)
//                .help(hint)
//        }
//        .buttonStyle(.plain)
//    }
//}
//
//struct TabButtonView_Previews: PreviewProvider {
//    static var previews: some View {
//        MenuSheetView(hint: "", sheetTitle: "", onClick: {}, onClose: {}, isPresented: .constant(false), height: 500)
//    }
//}
