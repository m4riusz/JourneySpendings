//
//  GRDBParticipant.swift
//  Core
//
//  Created by Mariusz Sut on 11/11/2021.
//

import Foundation
import GRDB

struct GRDBParticipant {
    var uuid: String?
    var journeyId: String?
    var name: String
}

extension GRDBParticipant {
    static let journey = belongsTo(GRDBJourney.self)

    var journey: QueryInterfaceRequest<GRDBJourney> {
        request(for: GRDBParticipant.journey)
    }
}

// MARK: - Codable
extension GRDBParticipant: Codable { /*Nop*/ }

// MARK: - TableRecord
extension GRDBParticipant: TableRecord {
    enum Columns {
        static let uuid = Column(CodingKeys.uuid)
        static let journeyId = Column(CodingKeys.journeyId)
        static let name = Column(CodingKeys.name)
    }
}

// MARK: - FetchableRecord
extension GRDBParticipant: FetchableRecord { /*Nop*/ }

// MARK: - MutablePersistableRecord
extension GRDBParticipant: MutablePersistableRecord {
    mutating func insert(_ db: Database) throws {
        if uuid.isNilOrEmpty {
            uuid = UUID().uuidString
        }
        try performInsert(db)
    }
}
