//
//  GRDBParticipantExpense.swift
//  Core
//
//  Created by Sut, Mariusz, (mBank/DBI) on 06/12/2021.
//

import Foundation
import GRDB

struct GRDBParticipantExpense {
    let participantId: String
    let expenseId: String
}

extension GRDBParticipantExpense {
    static let participant = belongsTo(GRDBParticipant.self)
    static let expense = belongsTo(GRDBExpense.self)
}

// MARK: - Codable
extension GRDBParticipantExpense: Codable { /*Nop*/ }

// MARK: - TableRecord
extension GRDBParticipantExpense: TableRecord {
    enum Columns {
        static let participantId = Column(CodingKeys.participantId)
        static let expenseId = Column(CodingKeys.expenseId)
    }
}

// MARK: - FetchableRecord
extension GRDBParticipantExpense: FetchableRecord { /*Nop*/ }
