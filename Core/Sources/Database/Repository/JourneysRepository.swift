//
//  JourneysRepository.swift
//  Core
//
//  Created by Mariusz Sut on 28/09/2021.
//

import RxSwift
import GRDB
import RxGRDB
import Foundation

final class JourneysRepository: JourneysRepositoryProtocol {
    private let databaseManager: DatabaseManagerProtocol
    private let dateProvider: DateProviderProtocol
    private var dbQueue: DatabaseQueue { databaseManager.databaseQueue! }

    init(databaseManager: DatabaseManagerProtocol, dateProvider: DateProviderProtocol) {
        self.databaseManager = databaseManager
        self.dateProvider = dateProvider
    }

    func create(name: String) -> Observable<Void> {
        dbQueue.rx.write { db in
            var entity = Journey(uuid: "",
                                 name: name,
                                 startDate: self.dateProvider.now,
                                 totalCost: 0,
                                 currency: "PLN").asGRDB
            try entity.insert(db)
        }
        .asObservable()
    }

    func journeyExists(name: String) -> Observable<Bool> {
        dbQueue.rx.read { db in
            try GRDBJourney.fetchOne(db, GRDBJourney.filter(GRDBJourney.Columns.name == name))
        }
        .map { $0 != nil }
        .asObservable()
    }

    func getCurrentJourneys() -> Observable<[Journey]> {
        ValueObservation.tracking { try GRDBJourney.fetchAll($0) }
            .rx
            .observe(in: dbQueue)
            .map { items in
                items.map { $0.asDomain }
            }
            .debug("ITEMS")
    }
}
