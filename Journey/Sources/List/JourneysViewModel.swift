//
//  JourneysViewModel.swift
//  Journey
//
//  Created by Mariusz Sut on 13/08/2021.
//

import Core
import RxSwift
import RxCocoa

final class JourneysViewModel: ViewModelType {
    struct Input {
        var load: Driver<Void>
    }
    struct Output {
        var items: Driver<[Section<JourneysItemCellViewModel>]>
    }
    var coordinator: JourneysCoordinatorProtocol!

    func transform(input: Input) -> Output {
        let items = input.load.asObservable()
            .flatMapLatest { _ -> Observable<[Section<JourneysItemCellViewModel>]> in
                .just([Section(title: "Aktualne",
                               items: [.init(uuid: "1", name: "Bieszczady", startDate: "10-10-2021", totalCost: "100,00 zł")]
                              ),
                       Section(title: "Archiwalne",
                                      items: [.init(uuid: "1", name: "Zakopane", startDate: "10-10-2000", totalCost: "2137,00 zł")]
                                     )
                      ])
            }

        return Output(items: items.asDriver())
    }
}
