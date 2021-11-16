//
//  JourneyDetailsViewModel.swift
//  Journey
//
//  Created by Mariusz Sut on 16/11/2021.
//

import Foundation
import Core

final class JourneyDetailsViewModel: ViewModelType {
    private let journeyId: String

    init(journeyId: String) {
        self.journeyId = journeyId
    }
    var coordinator: JourneyDetailsCoordinatorProtocol!

    func transform(input: Input) -> Output {
        Output()
    }
}

extension JourneyDetailsViewModel {
    struct Input {

    }
    struct Output {

    }
}
