//
//  JourneyCreateViewModel.swift
//  Journey
//
//  Created by Mariusz Sut on 19/10/2021.
//

import Foundation
import Core
import RxSwift
import RxCocoa

final class JourneyCreateViewModel: ViewModelType {
    private struct Constants {
        static let maxParticipantsCount = 5
        static let currency = "PLN"
    }
    private typealias Literals = Assets.Strings.Journey.Create
    private typealias Errors = Assets.Strings.Core.Error
    private let repository: JourneysRepositoryProtocol
    private let validatorProvider: JourneyValidatorProviderProtocol
    var coordinator: JourneyCreateCoordinatorProtocol!

    init(repository: JourneysRepositoryProtocol, validatorProvider: JourneyValidatorProviderProtocol) {
        self.repository = repository
        self.validatorProvider = validatorProvider
    }

    func transform(input: Input) -> Output {
        let participants = BehaviorRelay<[TagViewItem]>(value: [
            .deletable(viewModel: .init(text: Literals.People.Name.me, disabled: true))
        ])

        let name = input.name.distinctUntilChanged().asObservable()
        let lengthValidator = name.map { [weak self] name -> ValidationResult in
            guard let strongSelf = self else { return .success }
            return strongSelf.validatorProvider.journeyNameValidator.validate(text: name)
        }
        let uniqueValidator = name.flatMapLatest { [weak self] name -> Observable<ValidationResult> in
            guard let strongSelf = self else { return .empty() }
            return strongSelf.repository
                .journeyExists(name: name)
                .map { !$0 ? .success : .failure(message: Literals.Name.Error.alreadyExists) }
        }

        let nameError = Observable.combineLatest(lengthValidator, uniqueValidator)
            .map { [$0, $1].first(where: { !$0.isSuccess })?.error ?? "" }
            .asDriver()

        let canSave = nameError.map { $0.isEmpty }

        let participantName = input.participantName.distinctUntilChanged().asObservable().share()
        let addParticipant = input.addParticipant.asObservable().share()
        let deleteParticipant = input.deleteParticipant.asObservable().share()
        let distinctParticipants = participants.distinctUntilChanged().share(replay: 1)
        let addParticipantValidation = addParticipant
            .withLatestFrom(Observable.combineLatest(participantName, distinctParticipants))
            .map { [weak self] data -> ValidationResult in
                guard let strongSelf = self else { return .failure(message: Errors.internalMessage) }
                return strongSelf.validatorProvider
                    .participantNameValidator(participants: data.1.compactMap { $0.text })
                    .validate(text: data.0)
            }
            .share()
        let participantNameError = addParticipantValidation
            .map { $0.error ?? "" }
            .distinctUntilChanged()
            .asDriver()

        let addParticipantResult = addParticipant
            .withLatestFrom(Observable.combineLatest(participantName, addParticipantValidation))
            .filter { $0.1.isSuccess }
            .map { $0.0 }
            .do(onNext: { participants.append(.deletable(viewModel: .init(text: $0))) })
            .mapToVoid()
            .asDriver()

        let addParticipantEnabled = distinctParticipants
            .map { $0.count < Constants.maxParticipantsCount }
            .distinctUntilChanged()
            .asDriver()

        let deleteParticipantResult = deleteParticipant
            .do(onNext: { uuid in participants.accept(participants.value.filter { $0.uuid != uuid }) })
            .mapToVoid()
            .asDriver()

        let save = input.save.asObservable()
            .withLatestFrom(Observable.combineLatest(name, participants))
            .flatMapLatest { [weak self] data -> Observable<Void> in
                guard let strongSelf = self else { return .empty() }
                let participants = data.1.compactMap { $0.text }
                return strongSelf.repository
                    .create(name: data.0, currency: Constants.currency, participants: participants)
                    .catchAndReturn(())
            }
            .mapToVoid()
            .asDriver()

        let dismiss = Driver.of(save, input.cancel)
            .merge()
            .do(onNext: { [weak self] _ in self?.coordinator.didFinish() })

        return Output(canSave: canSave,
                      nameError: nameError,
                      dismiss: dismiss,
                      participants: distinctParticipants.asDriver(),
                      addParticipant: addParticipantResult,
                      addParticipantError: participantNameError,
                      addParticipantEnabled: addParticipantEnabled,
                      deleteParticipant: deleteParticipantResult)
    }
}

extension JourneyCreateViewModel {
    struct Input {
        let save: Driver<Void>
        let cancel: Driver<Void>
        let name: Driver<String>
        let participantName: Driver<String>
        let addParticipant: Driver<Void>
        let deleteParticipant: Driver<String>
    }

    struct Output {
        let canSave: Driver<Bool>
        let nameError: Driver<String>
        let dismiss: Driver<Void>
        let participants: Driver<[TagViewItem]>
        let addParticipant: Driver<Void>
        let addParticipantError: Driver<String>
        let addParticipantEnabled: Driver<Bool>
        let deleteParticipant: Driver<Void>
    }
}
