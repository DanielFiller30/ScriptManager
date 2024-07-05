//
//  ScriptProgressView.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 16.02.24.
//

import SwiftUI

struct ScriptProgressView: View {
    let height: CGFloat
    let value: Double
    @Binding var showDetails: Bool
    
    var body: some View {
        VStack {
            ProgressView(value: value)
                .progressViewStyle(customProgressView(height: height))
                .onTapGesture {
                    withAnimation {
                        showDetails.toggle()
                    }                    
                }
        }
    }
}

struct customProgressView: ProgressViewStyle {
    var stroke: Color = Color.white
    var fill = Material.ultraThinMaterial
    var caption: String = ""
    var cornerRadius: CGFloat = 15
    var height: CGFloat
    
    func makeBody(configuration: Configuration) -> some View {
        let fractionCompleted = configuration.fractionCompleted ?? 0
        
        return ZStack(alignment: .topLeading) {
            GeometryReader { geo in
                Rectangle()
                    .fill(fill)
                    .frame(maxWidth: geo.size.width * CGFloat(fractionCompleted))
            }
        }
        .frame(height: height)
        .cornerRadius(cornerRadius)
        .overlay(
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(.white, lineWidth: 0.5)
        )
        .shadow(radius: 3, x: 1, y: 2)
    }
}

#Preview {
    HStack {
        ScriptProgressView(height: 60, value: 1.0, showDetails: .constant(false))
    }
    .padding(20)
    .background(.ultraThickMaterial)
}
