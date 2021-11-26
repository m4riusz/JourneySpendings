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
    private typealias Literals = Assets.Strings.Journey.Details
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
        let selection = input.currentFilter.startWith("").asObservable()
        let allItem: Observable<TagViewItem> = .just(.selectable(viewModel: .init(text: Literals.Participant.all)))
        let participants = Observable.combineLatest(selection, allItem, journey)
            .flatMapLatest { data -> Observable<[TagViewItem]> in
                let selected = data.0
                let allItem: TagViewItem = .selectable(viewModel: .init(uuid: data.1.uuid,
                                                                        text: data.1.text,
                                                                        selected: (data.1.uuid == selected) || selected.isEmpty))
                var items: [TagViewItem] = data.2.participants
                    .enumerated()
                    .map { .selectable(viewModel: .init(uuid: $0.element.uuid,
                                                        text: $0.element.name,
                                                        selected: $0.element.uuid == selected)) }
                items.insert(allItem, at: 0)
                return .just(items)
                }
        .asDriver()
        return Output(journeyName: journeyName, participantFilters: participants)
    }
}

extension JourneyDetailsViewModel {
    struct Input {
        var load: Driver<Void>
        var currentFilter: Driver<String>
    }
    struct Output {
        var journeyName: Driver<String>
        var participantFilters: Driver<[TagViewItem]>
    }
}
