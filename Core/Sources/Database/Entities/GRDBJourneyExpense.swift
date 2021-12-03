//
//  GRDBJourneyExpense.swift
//  Core
//
//  Created by Sut, Mariusz, (mBank/DBI) on 03/12/2021.
//

import Foundation
import GRDB

struct GRDBJourneyExpense {
    var uuid: String?
    var journeyId: String?
    var name: String
    var date: Date
    var cost: Double
    var currency: String
}

extension GRDBJourneyExpense {
    static let participants = hasMany(GRDBParticipant.self)

    var participants: QueryInterfaceRequest<GRDBParticipant> {
        request(for: GRDBJourneyExpense.participants)
    }
}

// MARK: - Codable
extension GRDBJourneyExpense: Codable { /*Nop*/ }

// MARK: - TableRecord
extension GRDBJourneyExpense: TableRecord {
    enum Columns {
        static let uuid = Column(CodingKeys.uuid)
        static let journeyId = Column(CodingKeys.journeyId)
        static let name = Column(CodingKeys.name)
        static let date = Column(CodingKeys.date)
        static let cost = Column(CodingKeys.cost)
        static let currency = Column(CodingKeys.currency)
    }
}

// MARK: - FetchableRecord
extension GRDBJourneyExpense: FetchableRecord { /*Nop*/ }

// MARK: - MutablePersistableRecord
extension GRDBJourneyExpense: MutablePersistableRecord {
    mutating func insert(_ db: Database) throws {
        if uuid.isNilOrEmpty {
            uuid = UUID().uuidString
        }
        try performInsert(db)
    }
}
