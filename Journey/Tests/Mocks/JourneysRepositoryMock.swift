//
//  JourneysRepositoryMock.swift
//  JourneyTests
//
//  Created by Mariusz Sut on 07/10/2021.
//

import Core
import RxTest
import RxSwift

@testable import Journey

final class JourneysRepositoryMock: JourneysRepositoryProtocol {
    var getCurrentJourneysResult: Observable<[Journey]>!
    var journeyExistsResult: Observable<Bool>!
    var createResult: Observable<Void>!
    var getJourneyResult: Observable<Journey>!
    var getGetExpensesResult: Observable<[Expense]>!
    var getAddExpenseResult: Observable<Void>!
    
    func journeyExists(name: String) -> Observable<Bool> {
        journeyExistsResult
    }

    func getCurrentJourneys() -> Observable<[Journey]> {
        getCurrentJourneysResult
    }

    func create(name: String, participants: [String]) -> Observable<Void> {
        createResult
    }
    
    func getJourney(id: String) -> Observable<Journey> {
        getJourneyResult
    }
    
    func getExpenses(journeyId: String, participants: [String]) -> Observable<[Expense]> {
        getGetExpensesResult
    }
    
    func addExpense(name: String, totalCost: Double, journeyId: String, currencyId: String, participantsId: [String]) -> Observable<Void> {
        getAddExpenseResult
    }
}
