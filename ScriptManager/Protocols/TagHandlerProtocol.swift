//
//  TagHandlerProtocol.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 28.03.24.
//

import Foundation

protocol TagHandlerProtocol {
    var tags: [Tag] { get set }
    var selectedTag: UUID? { get set }
    
    func saveTags()
}
