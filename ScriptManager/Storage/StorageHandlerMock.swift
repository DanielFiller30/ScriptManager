//
//  StorageHandlerMock.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 30.07.24.
//

class StorageHandlerMock: StorageHandlerProtocol {
    var firstLaunch = false { didSet {
        print("Storage -- FirstLaunch set")
    }}
    
    var scripts: [Script] = [] { didSet {
        print("Storage -- Scripts set")
    }}
    
    var tags: [Tag] = [] { didSet {
        print("Storage -- Tags set")
    }}
    
    var times: [ScriptTime] = [] { didSet {
        print("Storage -- Times set")
    }}
    
    var settings: Settings = DefaultSettings { didSet {
        print("Storage -- Settings set")
    }}
    
    var cronJobs: [CronJob] = [] { didSet {
        print("Storage -- CronJobs set")
    }}
    
    func resetData() {
        print("Storage -- Reset data executed")
    }
    
    func resetValues(_ key: StorageKeys) {
        print("Storage -- Reset values executed for key: \(key)")
    }
    
    func setFirstLaunchToFalse() {
        print("Storage -- Toggled first launch")
    }
}
