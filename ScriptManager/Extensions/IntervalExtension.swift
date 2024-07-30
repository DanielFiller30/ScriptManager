//
//  IntervalExtension.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 29.07.24.
//

import Foundation

public extension Interval {
    func checkDiff(lastExecuted: Date) -> Bool {
        let calendar = Calendar.current
        var check: ComparisonResult
        
        switch self {
        case .DAILY:
            let oneDay = calendar.date(byAdding: .day, value: 1, to: lastExecuted)!
            check = calendar.compare(.now, to: oneDay, toGranularity: .day)
        case .WEEKLY:
            let oneWeek = calendar.date(byAdding: .weekOfYear, value: 1, to: lastExecuted)!
            check = calendar.compare(.now, to: oneWeek, toGranularity: .day)
        case .MONTHLY:
            let oneMonth = calendar.date(byAdding: .month, value: 1, to: lastExecuted)!
            check = calendar.compare(.now, to: oneMonth, toGranularity: .day)
        }
        
        if check == .orderedSame || check == .orderedDescending {
            return true
        } else {
            return false
        }
    }
}
