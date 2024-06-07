//
//  ScriptHandlerProtocol.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 04.04.23.
//

import Foundation

protocol ScriptHandlerProtocol {    
    var output: String { get }
    var finishedCounter: Int { get set }
    var scripts: [Script] { get set }
    var editScript: Script { get set }
    var editMode: Bool { get set }
    var savedScripts: [Script] { get }
    var times: [ScriptTime] { get set }
    var selectedIcon: Int { get set }

    func runScript(_ script: Script, test: Bool) async -> ResultState
    func interruptRunningProcess()
    func saveScripts()
}
