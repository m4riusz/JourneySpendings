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

    func create(name: String, participants: [String]) -> Observable<Void> {
        dbQueue.rx.write { [unowned self] db in
            let now = self.dateProvider.now
            var journey = GRDBJourney(name: name, startDate: now)
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
            .tracking {
                try GRDBJourneyInfo.fetchAll($0, GRDBJourney.including(all: GRDBJourney.participants)
                                                            .including(all: GRDBJourney.expenses
                                                                        .including(required: GRDBExpense.currency))) }
            .rx
            .observe(in: dbQueue)
            .map { items in items.map { $0.asJourney } }
    }

    func getJourney(id: String) -> Observable<Journey> {
        ValueObservation
            .tracking { db in
                try GRDBJourneyInfo.fetchOne(db, GRDBJourney.filter(GRDBJourney.Columns.uuid == id)
                                                            .including(all: GRDBJourney.participants)
                                                            .including(all: GRDBJourney.expenses
                                                                        .including(required: GRDBExpense.currency)))
            }
            .rx
            .observe(in: dbQueue)
            .flatMapLatest { item -> Observable<Journey> in
                guard let journey = item?.asJourney else { return .error(NSError(message: Assets.Strings.Core.Error.internalMessage)) }
                return .just(journey)
            }
    }
    
    func getExpenses(journeyId: String, participants: [String]) -> Observable<[Expense]> {
        ValueObservation
            .tracking { db in
                try GRDBExpense.filter(GRDBExpense.Columns.journeyId == journeyId)
                    .including(all: GRDBExpense.partExpenses
                                .including(required: GRDBExpensePart.participant)
                                .including(required: GRDBExpensePart.currency))
                    .having(GRDBExpense.partExpenses.filter(participants.contains(GRDBExpensePart.Columns.participantId)).count > 0)
                    .including(required: GRDBExpense.currency)
                    .asRequest(of: GRDBExpenseDetailsInfo.self)
                    .fetchAll(db)
            }
            .rx
            .observe(in: dbQueue)
            .flatMapLatest { expenses -> Observable<[Expense]> in
                let items = expenses
                    .map { expenseInfo -> Expense in
                    .init(uuid: expenseInfo.grdbExpense.uuid!,
                          currency: expenseInfo.grdbCurrency.asCurrency,
                          expenseParts: expenseInfo.grdbExpenseParts.map { $0.asExpensePart },
                          name: expenseInfo.grdbExpense.name,
                          date: expenseInfo.grdbExpense.date,
                          totalCost: expenseInfo.grdbExpense.totalCost)
                    }
            return .just(items)
            }
    }
    
    func addExpense(name: String, totalCost: Double, journeyId: String, currencyId: String, participantsId: [String]) -> Observable<Void> {
        dbQueue.rx.write { [unowned self] db in
            var expense = GRDBExpense(uuid: nil, journeyId: journeyId, currencyId: currencyId, name: name, date: self.dateProvider.now, totalCost: totalCost)
            try expense.save(db)
            participantsId
                .map { GRDBExpensePart(uuid: nil, participantId: $0, expenseId: expense.uuid, currencyId: currencyId, cost: totalCost / Double(participantsId.count)) }
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
    let grdbExpenses: [GRDBExpenseInfo]

    var asJourney: Journey {
        .init(uuid: grdbJourney.uuid!,
              name: grdbJourney.name,
              startDate: grdbJourney.startDate,
              totalCost: grdbExpenses.reduce(0, { $0 + $1.grdbExpense.totalCost} ),
              expenses: grdbExpenses.map { $0.asExpense },
              participants: grdbParticipants.map { .init(uuid: $0.uuid!, name: $0.name) })
    }
}

private struct GRDBExpenseInfo: FetchableRecord, Decodable {
    let grdbExpense: GRDBExpense
    let grdbCurrency: GRDBCurrency
    
    var asExpense: Expense {
        .init(uuid: grdbExpense.uuid!,
              currency: grdbCurrency.asCurrency,
              expenseParts: [],
              name: grdbExpense.name,
              date: grdbExpense.date,
              totalCost: grdbExpense.totalCost)
    }
}

private struct GRDBExpenseDetailsInfo: FetchableRecord, Decodable {
    let grdbExpense: GRDBExpense
    let grdbCurrency: GRDBCurrency
    let grdbExpenseParts: [GRDBExpensePartDetailsInfo]
    
    var asExpense: Expense {
        .init(uuid: grdbExpense.uuid!,
              currency: grdbCurrency.asCurrency,
              expenseParts: grdbExpenseParts.map { $0.asExpensePart },
              name: grdbExpense.name,
              date: grdbExpense.date,
              totalCost: grdbExpense.totalCost)
    }
}

private struct GRDBExpensePartDetailsInfo: FetchableRecord, Decodable {
    let grdbExpensePart: GRDBExpensePart
    let grdbCurrency: GRDBCurrency
    let grdbParticipant: GRDBParticipant
}

private extension GRDBExpensePartDetailsInfo {
    var asExpensePart: ExpensePart {
        .init(uuid: grdbExpensePart.uuid!,
              participant: grdbParticipant.asParticipant,
              currency: grdbCurrency.asCurrency,
              cost: grdbExpensePart.cost)
    }
}

private extension GRDBParticipant {
    var asParticipant: Participant {
        .init(uuid: uuid!,
              name: name)
    }
}
