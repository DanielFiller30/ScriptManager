//
//  CronJobHandler.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 29.07.24.
//

import Foundation
import Resolver

@Observable
class CronJobHandler: CronJobHandlerProtocol {
    @LazyInjected @ObservationIgnored private var storageHandler: StorageHandlerProtocol
    @LazyInjected @ObservationIgnored private var scriptHandler: ScriptHandlerProtocol
    
    var interval = 10.0
    private var savedCronjobs: [CronJob] {
        storageHandler.cronJobs
    }
    
    var cronJobs: [CronJob] = []
    
    init() {
        cronJobs = savedCronjobs
    }
    
    func start() {
        DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
            self.checkCronJobs()
        }
    }
    
    func addJob(job: CronJob) {
        storageHandler.cronJobs.append(job)
        cronJobs = storageHandler.cronJobs
    }
    
    func removeJob(id: UUID) {
        storageHandler.cronJobs = storageHandler.cronJobs.filter {
            $0.id != id
        }
        
        cronJobs = storageHandler.cronJobs
    }        
}

// MARK: - Helper functions
extension CronJobHandler {
    private func checkCronJobs() {
        savedCronjobs.forEach { job in
            if job.interval.checkDiff(lastExecuted: job.lastExecutedDate) {
                runCronJob(job: job)
            }
        }
    }
    
    private func runCronJob(job: CronJob) {
        Task {
            var tempJobs = savedCronjobs
            
            var runningJob = tempJobs.first(where: { $0.id == job.id })
            if runningJob == nil { return }
            
            let _ = await scriptHandler.runScript(runningJob!.script, test: true)
            
            runningJob!.lastExecutedDate = Date.now
            let index = tempJobs.firstIndex(where: { $0.id == runningJob?.id })!
            tempJobs[index] = runningJob!
            
            storageHandler.cronJobs = tempJobs
            cronJobs = storageHandler.cronJobs
        }
    }
}
