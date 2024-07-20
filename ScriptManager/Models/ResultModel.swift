//
//  ResultModel.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 04.02.23.
//

import Foundation

struct Result {
    var output: String?
    var error: String?
    var state: ResultState
}

enum ResultState: Codable {
    case successfull
    case failed
    case interrupted
    case ready
}
