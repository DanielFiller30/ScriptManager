//
//  HintHandlerProtocol.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 20.07.24.
//

protocol HintHandlerProtocol {
    var hintVisible: Bool { get }
    var hintText: String { get }
    var hintType: HintType { get }
    
    func showHint(_ text: String, type: HintType)
    func hideHint()
}
