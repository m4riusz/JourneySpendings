//
//  JourneysCoordinatorSpy.swift
//  Journey
//
//  Created by Mariusz Sut on 23/10/2021.
//

@testable import Journey

final class JourneysCoordinatorSpy: JourneysCoordinatorProtocol {
    private(set) var toCreateFormCallCout = 0

    func toCreateForm() {
        toCreateFormCallCout += 1
    }
}
