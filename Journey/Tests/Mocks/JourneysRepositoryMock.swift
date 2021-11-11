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

    func journeyExists(name: String) -> Observable<Bool> {
        journeyExistsResult
    }

    func getCurrentJourneys() -> Observable<[Journey]> {
        getCurrentJourneysResult
    }

    func create(name: String, currency: String, participants: [String]) -> Observable<Void> {
        createResult

    }
}
