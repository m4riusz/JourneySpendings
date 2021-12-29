//
//  GRDBExpensePart.swift
//  Core
//
//  Created by Sut, Mariusz, (mBank/DBI) on 23/12/2021.
//

import Foundation
import GRDB

struct GRDBExpensePart {
    var uuid: String?
    var participantId: String?
    var expenseId: String?
    var currencyId: String?
    var cost: Double
}

extension GRDBExpensePart {
    static let expense = belongsTo(GRDBExpense.self)
    static let currency = hasOne(GRDBCurrency.self, using: ForeignKey([GRDBCurrency.Columns.uuid], to: [Columns.currencyId]))
    static let participant = hasOne(GRDBParticipant.self, using: ForeignKey([GRDBParticipant.Columns.uuid], to: [Columns.participantId]))
}

// MARK: - Codable
extension GRDBExpensePart: Codable { /*Nop*/ }

// MARK: - TableRecord
extension GRDBExpensePart: TableRecord {
    enum Columns {
        static let uuid = Column(CodingKeys.uuid)
        static let participantId = Column(CodingKeys.participantId)
        static let expenseId = Column(CodingKeys.expenseId)
        static let currencyId = Column(CodingKeys.currencyId)
        static let cost = Column(CodingKeys.cost)
    }
}

// MARK: - GRDBExpensePart
extension GRDBExpensePart: FetchableRecord { /*Nop*/ }

// MARK: - MutablePersistableRecord
extension GRDBExpensePart: MutablePersistableRecord {
    mutating func insert(_ db: Database) throws {
        if uuid.isNilOrEmpty {
            uuid = UUID().uuidString
        }
        try performInsert(db)
    }
}
