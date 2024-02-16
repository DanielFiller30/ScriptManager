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
    
    var body: some View {
        VStack {
            ProgressView(value: value)
                .progressViewStyle(customProgressView(height: height))
        }
    }
}

struct customProgressView: ProgressViewStyle {
    var stroke: Color = Color.white
    var fill: Color = AppColor.Dark
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
        .background(AppColor.Dark.opacity(0.6))
        .cornerRadius(cornerRadius)
    }
}

#Preview {
    ScriptProgressView(height: 60, value: 1.0)
}
