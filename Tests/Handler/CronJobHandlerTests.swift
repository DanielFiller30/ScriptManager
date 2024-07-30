//
//  CronJobHandlerTests.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 30.07.24.
//

@testable import ScriptManager

import Resolver
import Testing
import Foundation

final class CronJobHandlerTests {
    @LazyInjected private var sut: CronJobHandlerProtocol
    @LazyInjected private var storageHandler: StorageHandlerProtocol
    
    let calendar = Calendar.current
    var testJob = CronJob(interval: .DAILY, script: DefaultScript, lastExecutedDate: .now)
    
    init() {
        let date = calendar.date(byAdding: .day, value: -1, to: .now)
        testJob.lastExecutedDate = date!
    }
    
    @Test("Add new cron job") func addJobTest() {
        sut.addJob(job: testJob)
        #expect(storageHandler.cronJobs.contains(where: { $0.id == testJob.id }) == true)
    }
    
    @Test("Remove cron job") func removeJobTest() {
        sut.addJob(job: testJob)
        #expect(storageHandler.cronJobs.contains(where: { $0.id == testJob.id }) == true)
        
        sut.removeJob(id: testJob.id)
        #expect(storageHandler.cronJobs.contains(where: { $0.id == testJob.id }) == false)
    }
    
//    @Test("Run cron job") func runJobTest() {
//        sut.addJob(job: testJob)
//        
//        sut.interval = 1.0
//        sut.start()
//        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//            let expectedResult = self.calendar.compare(self.sut.cronJobs.first!.lastExecutedDate, to: Date.now, toGranularity: .day)
//            #expect(expectedResult == .orderedSame)
//        }
//    }
}
