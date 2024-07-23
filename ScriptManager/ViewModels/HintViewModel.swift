//
//  HintViewModel.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 20.07.24.
//

import Resolver

class HintViewModel {
    @Injected var hintHandler: HintHandlerProtocol
    
    var hintType: HintType {
        hintHandler.hintType
    }
    
    var hintText: String {
        hintHandler.hintText
    }
    
    var icon: String {
        switch (hintType) {
        case .error: "xmark.circle.fill"
        case .warning: "exclamationmark.triangle.fill"
        case .success: "checkmark.seal.fill"
        }
    }
    
    func showHint(text: String, type: HintType) {
        hintHandler.showHint(text, type: type)
    }
    
    func hideHint() {
        hintHandler.hideHint()
    }
}
