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
    private let journeyRepository: JourneysRepositoryProtocol
    private let currencyRepository: CurrencyRepositoryProtocol

    init(journeyId: String, journeyRepository: JourneysRepositoryProtocol, currencyRepository: CurrencyRepositoryProtocol) {
        self.journeyId = journeyId
        self.journeyRepository = journeyRepository
        self.currencyRepository = currencyRepository
    }
    var coordinator: JourneyDetailsCoordinatorProtocol!

    func transform(input: Input) -> Output {
        let load = input.load.asObservable().share(replay: 1)
        let currency = load.flatMapLatest {  [weak self] _ -> Observable<Currency> in
            guard let stronSelf = self else { return .empty() }
            return stronSelf.currencyRepository.getCurrencies().map { $0.first! }
            }
            .share(replay: 1)
        let journey = load.flatMapLatest { [weak self] _ -> Observable<Journey> in
            guard let strongSelf = self else { return .empty() }
            return strongSelf.journeyRepository.getJourney(id: strongSelf.journeyId)
                .do(onError: { [weak self] _ in self?.coordinator.didFinish() })
            }
            .share(replay: 1)
        let journeyName = journey.map { $0.name }.asDriver()

        let selection = input.currentFilter.startWith("").asObservable()
        let participants = Observable.combineLatest(selection, journey)
            .flatMapLatest { [weak self] data -> Observable<[TagViewItem]> in
                guard let strongSelf = self else { return .empty() }
                return .just(strongSelf.participantsToTags(selected: data.0, participants: data.1.participants))
            }
            .distinctUntilChanged()
            .share(replay: 1)
        let add = input.addExpense.asObservable()
        let addResult = add.withLatestFrom(Observable.combineLatest(participants, currency, journey))
            .flatMapLatest { [weak self] data -> Observable<Void> in
                let participants = data.0.selectedItemUuids
                let currencyId = data.1.uuid
                let journeyId = data.2.uuid
                guard let strongSelf = self else { return .just(()) }
                return strongSelf.journeyRepository.addExpense(name: "Expense",
                                                               totalCost: 10,
                                                               journeyId: journeyId,
                                                               currencyId: currencyId,
                                                               participantsId: participants)
            }
            .asDriver()

        let items = Observable.combineLatest(journey, participants)
            .flatMapLatest { [weak self] data -> Observable<[Expense]> in
                guard let strongSelf = self else { return .just([]) }
                return strongSelf.journeyRepository
                    .getExpenses(journeyId: data.0.uuid, participants: data.1.selectedItemUuids)
                    .catchAndReturn([])
            }
            .map { [weak self] items -> [SectionViewModel<JourneyDetailsListItem>] in
                guard let strongSelf = self else { return [] }
                return strongSelf.mapToSection(items: items)
            }
            .asDriver(onErrorJustReturn: [])
        return Output(journeyName: journeyName,
                      participantFilters: participants.asDriver(),
                      items: items,
                      addResult: addResult)
    }
}

extension JourneyDetailsViewModel {
    struct Input {
        var load: Driver<Void>
        var currentFilter: Driver<String>
        var addExpense: Driver<Void>
    }
    struct Output {
        var journeyName: Driver<String>
        var participantFilters: Driver<[TagViewItem]>
        var items: Driver<[SectionViewModel<JourneyDetailsListItem>]>
        var addResult: Driver<Void>
    }
}

// MARK: - Private
private extension JourneyDetailsViewModel {
    var emptyViewModel: JourneyDetailsListItem {
        .empty(viewModel: .init(image: Assets.Images.Core.bagSuitcaseOutline,
                                title: Literals.Expense.Empty.title,
                                description: Literals.Expense.Empty.description))
    }

    func mapToSection(items: [Expense]) -> [SectionViewModel<JourneyDetailsListItem>] {
        guard !items.isEmpty else {
            return [.init(items: [emptyViewModel])]
        }
        return Dictionary(grouping: items, by: { $0.date.ddMMyyyyDoted })
            .map { group -> SectionViewModel<JourneyDetailsListItem> in
                let items = group.value
                    .sorted(by: { $0.date > $1.date })
                    .map { expenceToCellViewModel(expense: $0) }
                    .map { JourneyDetailsListItem.expense(viewModel: $0) }
                return .init(title: group.key, items: items)
            }
    }

    func expenceToCellViewModel(expense: Expense) -> JourneyExpenseCellViewModel {
        .init(uuid: expense.uuid,
              title: expense.name,
              persons: expense.expenseParts.map { $0.participant.name }.joined,
              cost: Amount(value: expense.totalCost, currency: expense.currency.symbol).formated())
    }

    func participantsToTags(selected: String, participants: [Participant]) -> [TagViewItem] {
        let selected = selected.isEmpty ? participants.first?.uuid : selected
        return participants
            .map { SelectableTagViewCellViewModel(uuid: $0.uuid, text: $0.name, selected: $0.uuid == selected) }
            .map { .selectable(viewModel: $0) }
    }
}
