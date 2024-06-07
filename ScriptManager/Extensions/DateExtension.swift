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
}
