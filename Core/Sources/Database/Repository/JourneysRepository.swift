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

    func create(name: String, currency: String, participants: [String]) -> Observable<Void> {
        dbQueue.rx.write { [unowned self] db in
            let now = self.dateProvider.now
            var journey = GRDBJourney(name: name, startDate: now, totalCost: 0, currency: currency)
            try journey.insert(db)

            var participants = participants.map { GRDBParticipant(journeyId: journey.uuid!, name: $0) }
            try participants.mutateEach(by: { try $0.insert(db) })
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
        ValueObservation
            .tracking { try GRDBJourneyInfo.fetchAll($0, GRDBJourney.including(all: GRDBJourney.participants)) }
            .rx
            .observe(in: dbQueue)
            .map { items in items.map { $0.asJourney } }
    }
}

private struct GRDBJourneyInfo: FetchableRecord, Decodable {
    let grdbJourney: GRDBJourney
    let grdbParticipants: [GRDBParticipant]

    var asJourney: Journey {
        .init(uuid: grdbJourney.uuid!,
              name: grdbJourney.name,
              startDate: grdbJourney.startDate,
              totalCost: grdbJourney.totalCost,
              currency: grdbJourney.currency,
              participants: grdbParticipants.map { .init(uuid: $0.uuid!, name: $0.name) })
    }
}
