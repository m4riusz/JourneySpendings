//
//  JourneyDetailsViewModel.swift
//  Journey
//
//  Created by Mariusz Sut on 16/11/2021.
//

import Foundation
import RxCocoa
import RxSwift
import Core

final class JourneyDetailsViewModel: ViewModelType {
    private let journeyId: String
    private let repository: JourneysRepositoryProtocol
    
    init(journeyId: String, repository: JourneysRepositoryProtocol) {
        self.journeyId = journeyId
        self.repository = repository
    }
    var coordinator: JourneyDetailsCoordinatorProtocol!

    func transform(input: Input) -> Output {
        let journey = input.load.asObservable()
            .flatMapLatest { [weak self] _ -> Observable<Journey> in
                guard let strongSelf = self else { return .empty() }
                return strongSelf.repository
                    .getJourney(id: strongSelf.journeyId)
                    .do(onError: { [weak self] _ in
                        self?.coordinator.didFinish()
                    })
            }
            .share(replay: 1)
        
        let journeyName = journey.map { $0.name }.asDriver()
        
        let participants = journey.flatMapLatest { journey -> Observable<[TagViewItem]> in
            let items = journey.participants.enumerated()
            return .just(items.map { .selectable(viewModel: .init(text: $0.element.name, selected: $0.offset == 0)) })
        }
        .asDriver()
        return Output(journeyName: journeyName, participants: participants)
    }
}

extension JourneyDetailsViewModel {
    struct Input {
        var load: Driver<Void>
    }
    struct Output {
        var journeyName: Driver<String>
        var participants: Driver<[TagViewItem]>
    }
}
