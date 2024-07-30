//
//  IntervalTests.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 29.07.24.
//

@testable import ScriptManager

import Testing
import Foundation

struct IntervalTests {
    
    struct DailyJob {
        let calendar = Calendar.current

        @Test("Run daily job") func testDailyTrue() async throws {
            let interval: Interval = .DAILY
            
            var checkDate = calendar.date(byAdding: .day, value: -1, to: Date.now)
            var expectedResult = interval.checkDiff(lastExecuted: checkDate!)
            #expect(expectedResult == true)
            
            checkDate = calendar.date(byAdding: .day, value: -20, to: Date.now)
            expectedResult = interval.checkDiff(lastExecuted: checkDate!)
            #expect(expectedResult == true)
        }
        
        @Test("Don't run daily job") func testDailyFalse() async throws {
            let interval: Interval = .DAILY
            
            var checkDate = calendar.date(byAdding: .day, value: 1, to: Date.now)
            var expectedResult = interval.checkDiff(lastExecuted: checkDate!)
            #expect(expectedResult == false)
            
            checkDate = calendar.date(byAdding: .day, value: 20, to: Date.now)
            expectedResult = interval.checkDiff(lastExecuted: checkDate!)
            #expect(expectedResult == false)
        }
    }
    
    struct WeeklyJob {
        let calendar = Calendar.current

        @Test("Run weekly job") func testWeeklyTrue() async throws {
            let interval: Interval = .WEEKLY
            
            var checkDate = calendar.date(byAdding: .weekOfMonth, value: -1, to: Date.now)
            var expectedResult = interval.checkDiff(lastExecuted: checkDate!)
            #expect(expectedResult == true)
            
            checkDate = calendar.date(byAdding: .weekOfMonth, value: -20, to: Date.now)
            expectedResult = interval.checkDiff(lastExecuted: checkDate!)
            #expect(expectedResult == true)
        }

        @Test("Don't run weekly job") func testWeeklyFalse() async throws {
            let interval: Interval = .WEEKLY
            
            var checkDate = calendar.date(byAdding: .weekOfMonth, value: 1, to: Date.now)
            var expectedResult = interval.checkDiff(lastExecuted: checkDate!)
            #expect(expectedResult == false)
            
            checkDate = calendar.date(byAdding: .weekOfMonth, value: 20, to: Date.now)
            expectedResult = interval.checkDiff(lastExecuted: checkDate!)
            #expect(expectedResult == false)
        }
    }
    
    struct MonthlyJob {
        let calendar = Calendar.current

        @Test("Run monthly job") func testMonthlyTrue() async throws {
            let interval: Interval = .MONTHLY
            
            var checkDate = calendar.date(byAdding: .month, value: -1, to: Date.now)
            var expectedResult = interval.checkDiff(lastExecuted: checkDate!)
            #expect(expectedResult == true)
            
            checkDate = calendar.date(byAdding: .month, value: -20, to: Date.now)
            expectedResult = interval.checkDiff(lastExecuted: checkDate!)
            #expect(expectedResult == true)
        }
        
        @Test("Don't run monthly job") func testMonthlyFalse() async throws {
            let interval: Interval = .MONTHLY
            
            var checkDate = calendar.date(byAdding: .month, value: 1, to: Date.now)
            var expectedResult = interval.checkDiff(lastExecuted: checkDate!)
            #expect(expectedResult == false)
            
            checkDate = calendar.date(byAdding: .month, value: 20, to: Date.now)
            expectedResult = interval.checkDiff(lastExecuted: checkDate!)
            #expect(expectedResult == false)
        }
    }
}
