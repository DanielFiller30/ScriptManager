//
//  ScriptTimeModel.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 16.02.24.
//

import Foundation

struct ScriptTime: Codable {
    var lastTime: Int?
    var currentTime = 0
    var remainingTime: String?
    var progressValue = 1.0
}

let DefaultScriptTime = ScriptTime(
    lastTime: nil,
    currentTime: 0,
    remainingTime: nil,
    progressValue: 1.0
)
