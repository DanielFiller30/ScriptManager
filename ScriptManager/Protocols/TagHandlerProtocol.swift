//
//  TagHandlerProtocol.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 28.03.24.
//

import Foundation
import SwiftUI

protocol TagHandlerProtocol {
    var editMode: Bool { get set }
    var tags: [Tag] { get set }
    var selectedTag: UUID? { get set }
    var editTag: Tag { get set }
    var editColor: Color { get set }
    
    func saveTags()
}
