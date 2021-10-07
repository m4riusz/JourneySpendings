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

    func getCurrentJourneys() -> Observable<[Journey]> {
        getCurrentJourneysResult
    }
}
