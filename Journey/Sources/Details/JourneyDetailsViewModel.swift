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
        let load = input.load.asObservable().share(replay: 1)
        let journey = load
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
        
        let items = load
            .flatMapLatest { _ -> Observable<[SectionViewModel<JourneyDetailsListItem>]> in
                return .just([.init(title: "19.01.2021", items: [
                    .expense(viewModel: .init(uuid: "1", title: "Bardzo długa nazwa mieszcząca się w 2 linikach", persons: "ja", cost: "1 230,00 PLN")),
                    .expense(viewModel: .init(uuid: "2", title: "Browary od stasia", persons: "Tomek", cost: "250,00 PLN")),
                    .expense(viewModel: .init(uuid: "3", title: "Zakupy carrefour", persons: "Maciek i Robert", cost: "0,00 PLN")),
                    .expense(viewModel: .init(uuid: "4", title: "Wypożyczenie kajaków na 5 dni", persons: "Kajak", cost: "130,00 PLN"))
                ])])
            }
            .asDriver(onErrorJustReturn: [])
        return Output(journeyName: journeyName, participantFilters: participants, items: items)
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
        var items: Driver<[SectionViewModel<JourneyDetailsListItem>]>
    }
}
