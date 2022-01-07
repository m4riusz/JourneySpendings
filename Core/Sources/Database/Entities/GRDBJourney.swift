//
//  GRDBJourney.swift
//  Core
//
//  Created by Mariusz Sut on 10/11/2021.
//

import Foundation
import GRDB

struct GRDBJourney {
    var uuid: String?
    var name: String
    var startDate: Date
}

extension GRDBJourney {
    static let participants = hasMany(GRDBParticipant.self)
    static let expenses = hasMany(GRDBExpense.self)

    var participants: QueryInterfaceRequest<GRDBParticipant> {
        request(for: GRDBJourney.participants)
    }

    var expenses: QueryInterfaceRequest<GRDBExpense> {
        request(for: GRDBJourney.expenses)
    }
}

// MARK: - Codable
extension GRDBJourney: Codable { /*Nop*/ }

// MARK: - TableRecord
extension GRDBJourney: TableRecord {
    enum Columns {
        static let uuid = Column(CodingKeys.uuid)
        static let name = Column(CodingKeys.name)
        static let startDate = Column(CodingKeys.startDate)
    }
}

// MARK: - FetchableRecord
extension GRDBJourney: FetchableRecord { /*Nop*/ }

// MARK: - MutablePersistableRecord
extension GRDBJourney: MutablePersistableRecord {
    mutating func insert(_ db: Database) throws {
        if uuid.isNilOrEmpty {
            uuid = UUID().uuidString
        }
        try performInsert(db)
    }
}
