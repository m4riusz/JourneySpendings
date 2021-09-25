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
        var items: Driver<[CellRepresentable]>
    }
    var coordinator: JourneysCoordinatorProtocol!

    func transform(input: Input) -> Output {
        let items = input.load.asObservable()
            .flatMapLatest { _ -> Observable<[CellRepresentable]> in
                return .just([])
            }

        return Output(items: items.asDriver(onErrorJustReturn: []))
    }
}
