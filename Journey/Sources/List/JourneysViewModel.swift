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

final class JourneysViewModel: ViewModelType {
    struct Input {
        var load: Driver<Void>
    }
    struct Output {
        var items: Driver<[Section<JourneysItemCellViewModel>]>
    }
    private let repository: JourneysRepositoryProtocol
    var coordinator: JourneysCoordinatorProtocol!

    init(repository: JourneysRepositoryProtocol) {
        self.repository = repository
    }

    func transform(input: Input) -> Output {
        let items = input.load.asObservable()
            .flatMapLatest(repository.getCurrentJourneys)
            .map { items -> [Section<JourneysItemCellViewModel>] in
                [Section(items: items.map { .init(uuid: $0.uuid,
                                                  name: $0.name,
                                                  startDate: $0.startDate.ddMMyyyy,
                                                  totalCost: "") })] // TODO: - create amount formatter
            }
            .asDriver()

        return Output(items: items)
    }
}
