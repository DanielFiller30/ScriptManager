//
//  ResultModel.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 04.02.23.
//

import Foundation

enum ResultState: Codable {
    case successfull
    case failed
    case interrupted
    case ready
}
