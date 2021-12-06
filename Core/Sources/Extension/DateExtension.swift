//
//  DateExtension.swift
//  Core
//
//  Created by Mariusz Sut on 28/09/2021.
//

import Foundation

public extension Date {
    private struct Costants {
        static let ddMMyyyyFormat = "dd-MM-yyyy"
        static let ddMMyyyyFormatDoted = "dd.MM.yyyy"
    }

    static func from(year: Int, month: Int, day: Int) -> Date {
        let dateComponents = DateComponents(year: year, month: month, day: day)
        return NSCalendar.current.date(from: dateComponents)!
    }

    var ddMMyyyy: String {
        let formatter = DateFormatter()
        formatter.dateFormat = Costants.ddMMyyyyFormat
        return formatter.string(from: self)
    }
    
    var ddMMyyyyDoted: String {
        let formatter = DateFormatter()
        formatter.dateFormat = Costants.ddMMyyyyFormatDoted
        return formatter.string(from: self)
    }
}
