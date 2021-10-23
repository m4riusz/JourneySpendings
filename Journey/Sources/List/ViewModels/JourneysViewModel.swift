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

final class JourneysViewModel: ViewModelType {
    private typealias CoreImages = Assets.Images.Core
    private typealias Literals = Assets.Strings.Journey.List
    private let repository: JourneysRepositoryProtocol
    var coordinator: JourneysCoordinatorProtocol!

    init(repository: JourneysRepositoryProtocol) {
        self.repository = repository
    }

    func transform(input: Input) -> Output {
        let items = input.load.asObservable()
            .flatMapLatest { [weak self] _ -> Observable<[Journey]> in
                guard let strongSelf = self else { return .empty() }
                return strongSelf.repository.getCurrentJourneys()
                    .catchAndReturn([])
            }
            .map { items -> [JourneysListItem] in
                guard !items.isEmpty else {
                    return [.empty(viewModel: .init(image: CoreImages.bagSuitcaseOutline,
                                                    title: Literals.Empty.title,
                                                    description: Literals.Empty.descrption,
                                                    buttonText: Literals.Empty.action))]
                }
                return items.map { .journey(viewModel: $0.asViewModel) }
            }
            .map { [Section(items: $0)] }
            .asDriver()
        let createJourney = input.createJournerTrigger
            .do(onNext: { [weak self] _ in
                self?.coordinator.toCreateForm()
            })

        return Output(items: items, createJourney: createJourney)
    }
}

extension JourneysViewModel {
    struct Input {
        var load: Driver<Void>
        var createJournerTrigger: Driver<Void>
    }
    struct Output {
        var items: Driver<[Section<JourneysListItem>]>
        var createJourney: Driver<Void>
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