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

    func getJourney(id: String) -> Observable<Journey> {
        ValueObservation
            .tracking { db in
                try GRDBJourneyInfo.fetchOne(db, GRDBJourney.filter(GRDBJourney.Columns.uuid == id).including(all: GRDBJourney.participants))
            }
            .rx
            .observe(in: dbQueue)
            .flatMapLatest { item -> Observable<Journey> in
                guard let journey = item?.asJourney else { return .error(NSError(message: Assets.Strings.Core.Error.internalMessage)) }
                return .just(journey)
            }
    }
    
    func getExpenses(participants: [String]) -> Observable<[Expense]> {
        ValueObservation
            .tracking { db in
                try GRDBParticipantExpense.filter(participants.contains(Column(GRDBParticipantExpense.Columns.participantId.name)))
                    .fetchAll(db)
            }
            .rx
            .observe(in: dbQueue)
            .distinctUntilChanged()
            .flatMapLatest { items -> Observable<[Expense]> in
            .just(items
                    .groupByExpenses
                    .compactMap { [weak self] data -> Expense? in
                        guard let strongSelf = self else { return nil }
                        let expense = try? strongSelf.dbQueue.read { try GRDBExpense.fetchOne($0, key: data.key) }
                        let participants = try? strongSelf.dbQueue.read { try GRDBParticipant.fetchAll($0, keys: data.value) }
                        return expense?.asDomain(participants: participants)
                    }
                )
            }
    }
    
    func addExpense(name: String, totalCost: Double, participants: [String], currency: String) -> Observable<Void> {
        dbQueue.rx.write { [unowned self] db in
            var expense = GRDBExpense(uuid: nil, name: name, date: self.dateProvider.now, cost: totalCost, currency: currency)
            try expense.save(db)
            participants
                .map { GRDBParticipantExpense(participantId: $0, expenseId: expense.uuid!) }
                .forEach {
                    var value = $0
                    try! value.save(db)
                }
        }
        .asObservable()
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

private extension GRDBExpense {
    func asDomain(participants: [GRDBParticipant]?) -> Expense {
        .init(uuid: uuid!,
              name: name,
              date: date,
              totalCost: cost,
              currency: currency,
              participants: participants?.map { $0.asDomain } ?? [] )
    }
}

private extension GRDBParticipant {
    var asDomain: Participant {
        .init(uuid: uuid!, name: name)
    }
}

private extension Array where Element == GRDBParticipantExpense {
    var groupByExpenses: [String: [String]] {
        reduce(into: [String: [String]]()) { partialResult, item in
            if var value = partialResult[item.expenseId] {
                value.append(item.participantId)
            } else {
                partialResult[item.expenseId] = [item.participantId]
            }
        }
    }
}
