//
//  CronJobModel.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 29.07.24.
//

import Foundation

struct CronJob: Identifiable, Codable {
    var id = UUID()
    var interval: Interval
    var script: Script
    var lastExecutedDate: Date
}

public enum Interval: Codable {
    case DAILY
    case WEEKLY
    case MONTHLY
}
