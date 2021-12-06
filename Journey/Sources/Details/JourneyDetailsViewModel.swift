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
            .share(replay: 1)
        
        
        let items = Observable.combineLatest(journey, participants, allItem)
            .flatMapLatest { [weak self] data -> Observable<[Expense]> in
                guard let strongSelf = self else { return .just([]) }
                let allParticipants = data.0.participants.compactMap { $0.uuid }
                let participants = data.1.selectableItems.filter { $0.selected }.compactMap { $0.uuid }
                let allItemId = data.2.uuid
                let isAllItemSelected = data.1.selectableItems.first(where: { $0.uuid == allItemId } )?.selected ?? false
                
                return strongSelf.repository
                    .getExpenses(participants: isAllItemSelected ? allParticipants : participants)
                    .catchAndReturn([])
            }
            .map { data -> [SectionViewModel<JourneyDetailsListItem>] in
                data
                    .sorted(by: { $0.date > $1.date })
                    .reduce(into: [String: [Expense]]()) { partialResult, expense in
                        if partialResult[expense.date.ddMMyyyyDoted] != nil {
                            partialResult[expense.date.ddMMyyyyDoted]?.append(expense)
                        } else {
                            partialResult[expense.date.ddMMyyyyDoted] = [expense]
                        }
                    }
                    .map { tuple -> SectionViewModel<JourneyDetailsListItem> in
                        let items = tuple.value.map { JourneyExpenseCellViewModel(uuid: $0.uuid, title: $0.name, persons: "pers", cost: "PLS") }
                        return SectionViewModel<JourneyDetailsListItem>(title: tuple.key, items: items.map { .expense(viewModel: $0) })
                    }
            }
            .asDriver(onErrorJustReturn: [])
        return Output(journeyName: journeyName, participantFilters: participants.asDriver(), items: items)
    }
}

extension Array where Element == TagViewItem {
    var selectableItems: [SelectableTagViewCellViewModel] {
        compactMap { item -> SelectableTagViewCellViewModel? in
            guard case let .selectable(model) = item else { return nil }
            return model
        }
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
