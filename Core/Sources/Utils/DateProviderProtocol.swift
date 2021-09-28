//
//  DateProviderProtocol.swift
//  Core
//
//  Created by Mariusz Sut on 28/09/2021.
//

import Foundation

public protocol DateProviderProtocol {
    var now: Date { get }
}

final class DateProvider: DateProviderProtocol {
    var now: Date {
        Date()
    }
}
