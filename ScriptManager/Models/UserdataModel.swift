//
//  UserdataModel.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 20.07.24.
//

struct Userdata: Codable {
    var scripts: [Script]
    var times: [ScriptTime]
    var tags: [Tag]
    var settings: Settings
}
