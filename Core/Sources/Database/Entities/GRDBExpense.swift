//
//  GRDBExpense.swift
//  Core
//
//  Created by Sut, Mariusz, (mBank/DBI) on 03/12/2021.
//

import Foundation
import GRDB

struct GRDBExpense {
    var uuid: String?
    var journeyId: String?
    var currencyId: String?
    var name: String
    var date: Date
    var totalCost: Double
}

extension GRDBExpense {
    static let journey = belongsTo(GRDBJourney.self)
    static let currency = hasOne(GRDBCurrency.self, using: ForeignKey([GRDBCurrency.Columns.uuid], to: [Columns.currencyId]))
    static let partExpenses = hasMany(GRDBExpensePart.self, using: ForeignKey([GRDBExpensePart.Columns.expenseId], to: [Columns.uuid]))
}

// MARK: - Codable
extension GRDBExpense: Codable { /*Nop*/ }

// MARK: - TableRecord
extension GRDBExpense: TableRecord {
    enum Columns {
        static let uuid = Column(CodingKeys.uuid)
        static let journeyId = Column(CodingKeys.journeyId)
        static let currencyId = Column(CodingKeys.currencyId)
        static let name = Column(CodingKeys.name)
        static let date = Column(CodingKeys.date)
        static let totalCost = Column(CodingKeys.totalCost)
    }
}

// MARK: - FetchableRecord
extension GRDBExpense: FetchableRecord { /*Nop*/ }

// MARK: - MutablePersistableRecord
extension GRDBExpense: MutablePersistableRecord {
    mutating func insert(_ db: Database) throws {
        if uuid.isNilOrEmpty {
            uuid = UUID().uuidString
        }
        try performInsert(db)
    }
}
