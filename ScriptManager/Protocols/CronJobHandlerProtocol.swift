//
//  CronJobHandlerProtocol.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 29.07.24.
//

import Foundation

protocol CronJobHandlerProtocol {
    var cronJobs: [CronJob] { get }
    var interval: Double { get set }

    func start()
    func addJob(job: CronJob)
    func removeJob(id: UUID)
}
