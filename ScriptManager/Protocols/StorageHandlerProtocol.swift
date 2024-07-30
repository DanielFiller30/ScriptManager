//
//  StorageHandlerProtocol.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 05.04.23.
//

import Foundation

protocol StorageHandlerProtocol {
    var firstLaunch: Bool { get set }
    var scripts: [Script] { get set }
    var tags: [Tag] { get set }
    var times: [ScriptTime] { get set }
    var settings: Settings { get set }
    var cronJobs: [CronJob] { get set }
    
    func resetData()
    func resetValues(_ key: StorageKeys)
    func setFirstLaunchToFalse()
}
