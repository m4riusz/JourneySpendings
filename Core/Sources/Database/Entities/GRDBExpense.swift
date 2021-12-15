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
    var name: String
    var date: Date
    var cost: Double
    var currency: String
}

extension GRDBExpense {
    static let participantExpense = hasMany(GRDBParticipantExpense.self)
    static let participant = hasMany(GRDBParticipant.self, through: participantExpense, using: GRDBParticipantExpense.participant)
    
    var participants: QueryInterfaceRequest<GRDBParticipant> {
        request(for: GRDBExpense.participant)
    }
}

// MARK: - Codable
extension GRDBExpense: Codable { /*Nop*/ }

// MARK: - TableRecord
extension GRDBExpense: TableRecord {
    enum Columns {
        static let uuid = Column(CodingKeys.uuid)
        static let name = Column(CodingKeys.name)
        static let date = Column(CodingKeys.date)
        static let cost = Column(CodingKeys.cost)
        static let currency = Column(CodingKeys.currency)
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
