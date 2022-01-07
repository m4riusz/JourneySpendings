//
//  GRDBCurrency.swift
//  Core
//
//  Created by Sut, Mariusz, (mBank/DBI) on 23/12/2021.
//

import Foundation
import GRDB

struct GRDBCurrency {
    var uuid: String?
    var code: String
    var symbol: String
}

// MARK: - Codable
extension GRDBCurrency: Codable { /*Nop*/ }

// MARK: - TableRecord
extension GRDBCurrency: TableRecord {
    enum Columns {
        static let uuid = Column(CodingKeys.uuid)
        static let code = Column(CodingKeys.code)
        static let symbol = Column(CodingKeys.symbol)
    }
}

// MARK: - FetchableRecord
extension GRDBCurrency: FetchableRecord { /*Nop*/ }

// MARK: - MutablePersistableRecord
extension GRDBCurrency: MutablePersistableRecord {
    mutating func insert(_ db: Database) throws {
        if uuid.isNilOrEmpty {
            uuid = UUID().uuidString
        }
        try performInsert(db)
    }
}
