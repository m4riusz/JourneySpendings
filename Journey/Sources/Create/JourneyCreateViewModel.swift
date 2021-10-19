//
//  JourneyCreateViewModel.swift
//  Journey
//
//  Created by Mariusz Sut on 19/10/2021.
//

import Foundation
import Core

final class JourneyCreateViewModel: ViewModelType {

    struct Input {

    }

    struct Output {

    }

    private let repository: JourneysRepositoryProtocol
    var coordinator: JourneyCreateCoordinatorProtocol!

    init(repository: JourneysRepositoryProtocol) {
        self.repository = repository
    }

    func transform(input: Input) -> Output {
        return Output()
    }
}
