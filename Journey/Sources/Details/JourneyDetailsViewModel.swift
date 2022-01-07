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
        let currency = currencyRepository.getCurrencies()
            .map { $0.first! }
            .share(replay: 1)
        let load = input.load.asObservable().share(replay: 1)
        let add = input.addExpense
        let journey = load
            .flatMapLatest { [weak self] _ -> Observable<Journey> in
                guard let strongSelf = self else { return .empty() }
                return strongSelf.journeyRepository
                    .getJourney(id: strongSelf.journeyId)
                    .do(onError: { [weak self] _ in
                        self?.coordinator.didFinish()
                    })
            }
            .share(replay: 1)

        let journeyName = journey.map { $0.name }.asDriver()
        let selection = input.currentFilter.startWith("").asObservable()
        let allItem: Observable<TagViewItem> = .just(.selectable(viewModel: .init(text: Literals.Participant.all))).share(replay: 1)
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
            .distinctUntilChanged()
            .share(replay: 1)
        
        let addResult = add.asObservable().withLatestFrom(Observable.combineLatest(participants, currency, journey))
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

        
        let items = Observable.combineLatest(journey, participants, allItem)
            .flatMapLatest { [weak self] data -> Observable<[Expense]> in
                guard let strongSelf = self else { return .just([]) }
                let allParticipants = data.0.participants.compactMap { $0.uuid }
                let participants = data.1.selectableItems.filter { $0.selected }.compactMap { $0.uuid }
                let allItemId = data.2.uuid
                let isAllItemSelected = data.1.selectableItems.first(where: { $0.uuid == allItemId } )?.selected ?? false
                
                return strongSelf.journeyRepository
                    .getExpenses(journeyId: data.0.uuid, participants: isAllItemSelected ? allParticipants : participants)
                    .catchAndReturn([])
            }
            .map { data -> [SectionViewModel<JourneyDetailsListItem>] in
                if data.isEmpty {
                    return [.init(items: [.empty(viewModel: .init(image: Assets.Images.Core.bagSuitcaseOutline,
                                                                  title: Literals.Expense.Empty.title,
                                                                  description: Literals.Expense.Empty.description))])]
                }
                return data
                    .reduce(into: [String: [Expense]]()) { partialResult, expense in
                        if partialResult[expense.date.ddMMyyyyDoted] != nil {
                            partialResult[expense.date.ddMMyyyyDoted]?.append(expense)
                        } else {
                            partialResult[expense.date.ddMMyyyyDoted] = [expense]
                        }
                    }
                    .map { tuple -> SectionViewModel<JourneyDetailsListItem> in
                        let items = tuple.value
                            .sorted(by: { $0.date > $1.date })
                            .map { JourneyExpenseCellViewModel(uuid: $0.uuid,
                                                               title: $0.name,
                                                               persons: $0.expenseParts.map { $0.participant.name }.joined(separator: String.Common.commaSeparator),
                                                               cost: Amount(value: $0.totalCost, currency: $0.currency.symbol).formated())
                            }
                        return SectionViewModel<JourneyDetailsListItem>(title: tuple.key, items: items.map { .expense(viewModel: $0) })
                    }
            }
            .asDriver(onErrorJustReturn: [])
        return Output(journeyName: journeyName, participantFilters: participants.asDriver(), items: items, addResult: addResult)
    }
}

extension Array where Element == TagViewItem {
    var selectableItems: [SelectableTagViewCellViewModel] {
        compactMap { item -> SelectableTagViewCellViewModel? in
            guard case let .selectable(model) = item else { return nil }
            return model
        }
    }
    
    var selectedItemUuids: [String] {
        let selectableItems = selectableItems
        let allItemSelected = selectableItems.first?.selected == true
        if allItemSelected {
            return selectableItems.map { $0.uuid }.dropFirst().compactMap { $0 }
        } else if let selected = selectableItems.first(where: { $0.selected } )?.uuid {
            return [selected]
        } else {
            return []
        }
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
