//
//  ScriptHandlerProtocol.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 04.04.23.
//

import Foundation

protocol ScriptHandlerProtocol: ObservableObject {
    var settingsHandler: SettingsHandler { get }
    
    var output: String { get }
    
    func runScript(_ script: Script, test: Bool) async -> ResultState
    
    func handleScriptResult(result: Int32, test: Bool, scriptName: String) -> ResultState
    func writeLog(pathLogs: String)
}
