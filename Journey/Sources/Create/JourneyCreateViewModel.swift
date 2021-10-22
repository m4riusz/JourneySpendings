//
//  JourneyCreateViewModel.swift
//  Journey
//
//  Created by Mariusz Sut on 19/10/2021.
//

import Foundation
import Core
import RxSwift
import RxCocoa

final class JourneyCreateViewModel: ViewModelType {

    struct Input {

    }

    struct Output {
        var items: Driver<[Section<JourneyCreateListItem>]>
    }

    private let repository: JourneysRepositoryProtocol
    var coordinator: JourneyCreateCoordinatorProtocol!

    init(repository: JourneysRepositoryProtocol) {
        self.repository = repository
    }

    func transform(input: Input) -> Output {
        let items = BehaviorRelay<[Section<JourneyCreateListItem>]>(value: [
            .init(items: [
                .name(viewModel: TextFieldCellViewModel(uuid: "1",
                                                        title: "Name",
                                                        placeholder: "Text",
                                                        helper: "Helper",
                                                        error: "Error"))
            ])
        ])

        return Output(items: items.asDriver())
    }
}
