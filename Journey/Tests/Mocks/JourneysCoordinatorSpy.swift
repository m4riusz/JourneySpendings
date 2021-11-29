//
//  JourneysCoordinatorSpy.swift
//  Journey
//
//  Created by Mariusz Sut on 23/10/2021.
//

@testable import Journey

final class JourneysCoordinatorSpy: JourneysCoordinatorProtocol {
    private(set) var toCreateFormCallCout = 0
    private(set) var toDetailsJourneyId: String?

    func toCreateForm() {
        toCreateFormCallCout += 1
    }
    
    func toDetails(journeyId: String) {
        toDetailsJourneyId = journeyId
    }
}
