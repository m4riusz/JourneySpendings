//
//  Journey.swift
//  Core
//
//  Created by Mariusz Sut on 25/09/2021.
//

import Foundation

public struct Journey {
    public let uuid: String
    public let name: String
    public let startDate: Date
    public let totalCost: Double
    public let expenses: [Expense]
    public let participants: [Participant]

    public init(uuid: String,
                name: String,
                startDate: Date,
                totalCost: Double,
                expenses: [Expense],
                participants: [Participant]) {
        self.uuid = uuid
        self.name = name
        self.startDate = startDate
        self.totalCost = totalCost
        self.expenses = expenses
        self.participants = participants
    }
}
