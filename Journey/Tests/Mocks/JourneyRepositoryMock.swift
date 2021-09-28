//
//  JourneyRepositoryMock.swift
//  Journey
//
//  Created by Mariusz Sut on 28/09/2021.
//

import XCTest
import Core
import RxSwift

@testable import Journey

final class JourneyRepositoryMock: JourneysRepositoryProtocol {

    var getCurrentJourneysResults: Observable<[Journey]>!

    func getCurrentJourneys() -> Observable<[Journey]> {
        getCurrentJourneysResults
    }
}
