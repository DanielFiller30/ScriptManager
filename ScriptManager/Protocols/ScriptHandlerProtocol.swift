//
//  ScriptHandlerProtocol.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 04.04.23.
//

import Foundation

protocol ScriptHandlerProtocol {        
    var finishedCounter: Int { get set }
    
    var scripts: [Script] { get set }
    var editScript: Script { get set }
    var input: String { get set }

    var editMode: Bool { get set }
    var savedScripts: [Script] { get }
    var selectedIcon: Int { get set }
    var runningScript: [Script] { get set }

    func runScript(_ script: Script, test: Bool) async -> Result
    func interruptRunningProcess(scriptId: UUID)
    func saveScripts()
}
