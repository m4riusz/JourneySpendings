//
//  Expense.swift
//  Core
//
//  Created by Sut, Mariusz, (mBank/DBI) on 01/12/2021.
//

import Foundation

public struct Expense {
    public let uuid: String
    public let currency: Currency
    public let expenseParts: [ExpensePart]
    public let name: String
    public let date: Date
    public let totalCost: Double
}
