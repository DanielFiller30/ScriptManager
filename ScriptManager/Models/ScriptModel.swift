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
    var command: String
    var success: ResultState
    var finished: Bool
    var lastRun: Date?
    var tagID: UUID = EmptyTag.id
    var time: ScriptTime?
    var input: String?
}

let EmptyScript = Script(
    id: UUID(uuidString: "8ac5590d-68cf-48c6-83da-4a886f26f528") ?? UUID(),
    name: "",
    icon: "applescript",
    command: "cd /Desktop/ sh..",
    success: .ready,
    finished: false,
    lastRun: Date.now,
    tagID: EmptyTag.id,
    time: DefaultScriptTime,
    input: ""
)

let DefaultScript = Script(
    name: "Test",
    icon: "terminal",
    command: "/test",
    success: .ready,
    finished: false,
    time: DefaultScriptTime,
    input: ""
)
