//
//  ExpensePart.swift
//  Core
//
//  Created by Sut, Mariusz, (mBank/DBI) on 23/12/2021.
//

import Foundation

public struct ExpensePart {
    public let uuid: String
    public let expense: Expense
    public let participant: Participant
    public let currency: Currency
    public let cost: Double
}
