//
//  DataHandlerProtocol.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 05.04.23.
//

import Foundation

protocol DataHandlerProtocol: ObservableObject {
    static var shared: DataHandler { get }
    
    var tags: [Tag]  { get }
    var scripts: [Script] { get }
    
    init()
    func loadScripts()
    func loadTags()
}
