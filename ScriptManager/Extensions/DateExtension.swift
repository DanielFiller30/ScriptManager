//
//  DateExtension.swift
//  ScriptManager
//
//  Created by Filler, Daniel on 28.03.24.
//

import Foundation

extension Date {
    /// Convert Date to formatted String
    /// - Returns: formatted date as `String`
    func toFormattedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy HH:mm:ss"
        
        return dateFormatter.string(from: self)
    }
    
    /// Get String for date with local formatting
    ///  - Returns: String for date `ddMMyyyy`
    func toDateString() -> String {
        let customFormat = "ddMMyyyy"
        
        let localeFormat = DateFormatter.dateFormat(fromTemplate: customFormat, options: 0, locale: Locale.current)
        let formatter = DateFormatter()
        formatter.dateFormat = localeFormat
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        let dateString = formatter.string(from: self)
        return dateString
    }
}
