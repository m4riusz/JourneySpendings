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
    var totalCost: Double
    var currency: String
}

// MARK: - Codable
extension GRDBJourney: Codable { /*Nop*/ }

// MARK: - TableRecord
extension GRDBJourney: TableRecord {
    enum Columns {
        static let uuid = Column(CodingKeys.uuid)
        static let name = Column(CodingKeys.name)
        static let startDate = Column(CodingKeys.startDate)
        static let totalCost = Column(CodingKeys.totalCost)
        static let currency = Column(CodingKeys.currency)
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

// MARK: - FetchableRecord
extension GRDBJourney: DomainConvertibleType {
    var asDomain: Journey {
        .init(uuid: uuid!,
              name: name,
              startDate: startDate,
              totalCost: totalCost,
              currency: currency)
    }
}

// MARK: - GRDBRepresentable
extension Journey: GRDBRepresentable {
    var asGRDB: GRDBJourney {
        .init(uuid: uuid,
              name: name,
              startDate: startDate,
              totalCost: totalCost,
              currency: currency)
    }
}
