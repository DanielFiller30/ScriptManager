//
//  ScriptTimeModel.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 16.02.24.
//

import Foundation

struct ScriptTime: Codable {
    var scriptId: UUID
    var runningTimes: [Int] = []
    var currentTime = 0
    var remainingTime: String?
    var progressValue = 1.0
}
