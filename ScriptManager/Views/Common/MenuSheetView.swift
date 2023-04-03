//
//  TabButtonView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 28.03.23.
//

import SwiftUI

struct MenuSheetView<Content>: View where Content: View {
    let hint: LocalizedStringKey
    let sheetTitle: LocalizedStringKey
    let onClick: () -> Void
    let onClose: () -> Void
    let content: () -> Content
    let height: CGFloat
    
    let width: CGFloat = 350.0
    
    @Binding var isPresented: Bool
    
    init(
        hint: LocalizedStringKey,
        sheetTitle: LocalizedStringKey,
        onClick: @escaping () -> Void,
        onClose: @escaping () -> Void,
        isPresented: Binding<Bool>,
        height: CGFloat,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.hint = hint
        self.sheetTitle = sheetTitle
        self.onClick = onClick
        self.onClose = onClose
        self.content = content
        self.height = height
        
        self._isPresented = isPresented
    }
    
    var body: some View {
        Button {
            withAnimation {
                onClick()
            }
        } label: {
            Image(systemName: "plus")
                .resizable()
                .frame(width: IconSize.s, height: IconSize.s)
                .foregroundColor(Color.white)
                .help(hint)
        }
        .buttonStyle(.plain)
        .sheet(isPresented: $isPresented) {
            VStack(spacing: .zero) {
                HStack(alignment: .center) {
                    Text(sheetTitle)
                        .font(.system(size: FontSize.subTitle))
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    Button {
                        isPresented.toggle()
                        
                        onClose()
                    } label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .frame(width: IconSize.s, height: IconSize.s)
                    }
                    .buttonStyle(.plain)
                }
                .padding(.all, Spacing.xl)
                
                Divider()
                
                content()
                
                Spacer()
            }
            .frame(minWidth: width, maxWidth: width, minHeight: height)
            .background(AppColor.AppBg)
        }
    }
}

struct TabButtonView_Previews: PreviewProvider {
    static var previews: some View {
        MenuSheetView(hint: "", sheetTitle: "", onClick: {}, onClose: {}, isPresented: .constant(false), height: 500) {
            EmptyView()
        }
    }
}
