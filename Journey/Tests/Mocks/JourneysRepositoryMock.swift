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

    func journeyExists(name: String) -> Observable<Bool> {
        journeyExistsResult
    }

    func getCurrentJourneys() -> Observable<[Journey]> {
        getCurrentJourneysResult
    }
}
