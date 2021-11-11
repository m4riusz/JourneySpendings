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
        databaseQueue = DatabaseQueue()
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
                t.column("totalCost", .double).notNull(onConflict: .rollback)
                t.column("currency", .text).notNull(onConflict: .rollback)
                t.check(sql: "length(name) >= 4 AND length(name) <= 40")
                t.check(sql: "length(currency) == 3")
            }
            try database.create(table: "grdbParticipant", body: { t in
                t.column("uuid", .text).primaryKey()
                t.column("name", .text).notNull(onConflict: .rollback)
                t.column("journeyId", .text)
                    .notNull(onConflict: .rollback)
                    .references("grdbJourney", onDelete: .cascade, onUpdate: .cascade)
                t.uniqueKey(["uuid", "name"], onConflict: .rollback)
                t.check(sql: "length(name) >= 2 AND length(name) <= 30")
            })
        }

        return migrator
    }
}
