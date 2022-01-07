//
//  JourneysRepositoryProtocol.swift
//  Core
//
//  Created by Mariusz Sut on 28/09/2021.
//

import RxSwift

public protocol JourneysRepositoryProtocol {
    func create(name: String, participants: [String]) -> Observable<Void>
    func journeyExists(name: String) -> Observable<Bool>
    func getCurrentJourneys() -> Observable<[Journey]>
    func getJourney(id: String) -> Observable<Journey>
    func getExpenses(journeyId: String, participants: [String]) -> Observable<[Expense]>
    func addExpense(name: String, totalCost: Double, journeyId: String, currencyId: String, participantsId: [String]) -> Observable<Void>
}
