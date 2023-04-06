//
//  TagModel.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 27.03.23.
//

import Foundation
import SwiftUI

struct Tag: Identifiable, Codable {
    var id = UUID()
    var name: String
    var badgeColor: Data
}

let EmptyTag = Tag(
    id: UUID(uuidString: "6f7bcd9e-23dc-466c-85d3-4fc0ec5df5bb") ?? UUID(),
    name: "",
    badgeColor: ColorHandler.defaultEncodedColor
)
