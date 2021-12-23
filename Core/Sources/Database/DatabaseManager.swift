//
//  DatabaseManager.swift
//  Core
//
//  Created by Mariusz Sut on 10/11/2021.
//

import Foundation
import GRDB

protocol DatabaseManagerProtocol {
    var databaseQueue: DatabaseQueue? { get }
    func setup() throws
}

final class DatabaseManager: DatabaseManagerProtocol {
    var databaseQueue: DatabaseQueue?

    func setup() throws {
        var configuration = Configuration()
        configuration.prepareDatabase { db in
            db.trace { print($0) }
        }
        databaseQueue = DatabaseQueue(configuration: configuration)
        guard let dbQueue = databaseQueue else { fatalError("Unable to create database queue") }
        try migrator.migrate(dbQueue)
    }

    private var migrator: DatabaseMigrator {
        var migrator = DatabaseMigrator()
        migrator.eraseDatabaseOnSchemaChange = true
        migrator.registerMigration("creteProject") { database in
            try database.create(table: "grdbJourney") { t in
                t.column("uuid", .text).primaryKey()
                t.column("name", .text).notNull(onConflict: .rollback).unique(onConflict: .rollback)
                t.column("startDate", .date).notNull(onConflict: .rollback)
                t.check(sql: "length(name) >= 4 AND length(name) <= 40")
            }
            try database.create(table: "grdbCurrency", body: { t in
                t.column("uuid", .text).primaryKey()
                t.column("code", .text).notNull(onConflict: .rollback).unique(onConflict: .rollback)
                t.column("symbol", .text).notNull(onConflict: .rollback).unique(onConflict: .rollback)
            })
            try database.create(table: "grdbParticipant", body: { t in
                t.column("uuid", .text).primaryKey()
                t.column("journeyId", .text).notNull(onConflict: .rollback).references("grdbJourney", onDelete: .cascade, onUpdate: .cascade)
                t.column("name", .text).notNull(onConflict: .rollback)
                t.uniqueKey(["uuid", "name"], onConflict: .rollback)
                t.check(sql: "length(name) >= 2 AND length(name) <= 30")
            })
            try database.create(table: "grdbExpense", body: { t in
                t.column("uuid", .text).primaryKey()
                t.column("journeyId", .text).notNull(onConflict: .rollback).references("grdbJourney", onDelete: .cascade, onUpdate: .cascade)
                t.column("currencyId", .text).notNull(onConflict: .rollback).references("grdbCurrency", onDelete: .cascade, onUpdate: .cascade)
                t.column("name", .text).notNull(onConflict: .rollback)
                t.column("date", .date).notNull(onConflict: .rollback)
                t.column("totalCost", .double).notNull(onConflict: .rollback)
            })
            try database.create(table: "grdbExpensePart", body: { t in
                t.column("uuid", .text).primaryKey()
                t.column("expenseId", .text).notNull(onConflict: .rollback).references("grdbExpense", onDelete: .cascade, onUpdate: .cascade)
                t.column("participantId", .text).notNull().references("grdbParticipant")
                t.column("currencyId", .text).notNull(onConflict: .rollback).references("grdbCurrency", onDelete: .cascade, onUpdate: .cascade)
                t.column("cost", .double).notNull(onConflict: .rollback)
            })
        }
        migrator.registerMigration("insert basic data") { db in
            var polishCurrency = GRDBCurrency(uuid: nil, code: "PLN", symbol: "zł")
            try polishCurrency.save(db)
        }
        return migrator
    }
}
