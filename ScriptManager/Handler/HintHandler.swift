//
//  HintHandler.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 20.07.24.
//

import Foundation
import SwiftUI

@Observable
class HintHandler: HintHandlerProtocol {
    var hintVisible: Bool = false
    var hintText: String = "Test-Hint"
    var hintType: HintType = .warning
    
    func showHint(_ text: String, type: HintType) {
        hintText = text
        hintType = type
        
        withAnimation {
            self.hintVisible = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.hideHint()
        }
    }
    
    func hideHint() {
        withAnimation {
            self.hintVisible = false
        }
    }
}

public enum HintType {
    case warning
    case error
    case success
}
