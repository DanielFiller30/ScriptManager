//
//  ScriptModel.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 03.02.23.
//

import Foundation

struct Script: Identifiable, Codable {
    var id = UUID()
    var name: String
    var icon: String
    var path: String
    var success: ResultState
    var finished: Bool
    var lastRun: Date?
}
