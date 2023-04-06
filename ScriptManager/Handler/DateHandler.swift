//
//  DateHandler.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 05.04.23.
//

import Foundation

class DateHandler: DateHandlerProtocol {
    static func getFormattedDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy HH:mm:ss"
        
        return dateFormatter.string(from: date)
    }
}
