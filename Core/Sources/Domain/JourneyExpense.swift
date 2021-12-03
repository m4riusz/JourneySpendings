//
//  JourneyExpense.swift
//  Core
//
//  Created by Sut, Mariusz, (mBank/DBI) on 01/12/2021.
//

import Foundation

public struct JourneyExpense {
    public let uuid: String
    public let name: String
    public let date: Date
    public let totalCost: Double
    public let currency: String
    public let participants: [Participant]

    public init(uuid: String,
                name: String,
                date: Date,
                totalCost: Double,
                currency: String,
                participants: [Participant]) {
        self.uuid = uuid
        self.name = name
        self.date = date
        self.totalCost = totalCost
        self.currency = currency
        self.participants = participants
    }
}
