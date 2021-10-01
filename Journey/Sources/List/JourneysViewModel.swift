//
//  JourneysViewModel.swift
//  Journey
//
//  Created by Mariusz Sut on 13/08/2021.
//

import Core
import RxSwift
import RxCocoa
import Foundation
import RxDataSources

enum JourneysSectionItem {
    case journey(viewModel: JourneysItemCellViewModel)
    case empty(viewModel: EmptyViewCellViewModel)
}

extension JourneysSectionItem: IdentifiableType {
    var identity: AnyHashable {
        switch self {
        case .journey(let viewModel):
            return viewModel.identity
        case .empty(let viewModel):
            return viewModel.identity
        }
    }
}

extension JourneysSectionItem: Equatable { /*Nop*/ }

final class JourneysViewModel: ViewModelType {
    struct Input {
        var load: Driver<Void>
    }
    struct Output {
        var items: Driver<[Section<JourneysSectionItem>]>
    }
    private let repository: JourneysRepositoryProtocol
    var coordinator: JourneysCoordinatorProtocol!

    init(repository: JourneysRepositoryProtocol) {
        self.repository = repository
    }

    func transform(input: Input) -> Output {
        let items = input.load.asObservable()
            .flatMapLatest(repository.getCurrentJourneys)
            .map { items -> [Section<JourneysSectionItem>] in
                [Section(items: items.map { .journey(viewModel: $0.asViewModel) }),
                 Section(items: [.empty(viewModel: .init(title: "Brak podróży",
                                                        description: "Aby dodać nową podróż kliknij dodaj",
                                                        buttonText: "dodaj"))])
                ]
            }
            .asDriver()

        return Output(items: items)
    }
}

fileprivate extension Journey {
    var asViewModel: JourneysItemCellViewModel {
        .init(uuid: uuid,
              name: name,
              startDate: startDate.ddMMyyyy,
              totalCost: Amount(value: totalCost, currency: currency).formated())
    }
}
