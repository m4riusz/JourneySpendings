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
    private typealias Literals = Assets.Strings.Journey.Create
    private let repository: JourneysRepositoryProtocol
    private let validatorProvider: JourneyValidatorProviderProtocol
    var coordinator: JourneyCreateCoordinatorProtocol!

    init(repository: JourneysRepositoryProtocol, validatorProvider: JourneyValidatorProviderProtocol) {
        self.repository = repository
        self.validatorProvider = validatorProvider
    }

    func transform(input: Input) -> Output {
        let participants = BehaviorRelay<[TagViewItem]>(value: [
            .deletable(viewModel: .init(uuid: UUID().uuidString, text: "Me", disabled: true))
        ])

        let name = input.name.distinctUntilChanged().asObservable()
        let lengthValidator = name.map { [weak self] name -> ValidationResult in
            guard let strongSelf = self else { return .success }
            return strongSelf.validatorProvider.journeyNameValidator.validate(text: name)
        }
        let uniqueValidator = name.flatMapLatest { [weak self] name -> Observable<Bool> in
            guard let strongSelf = self else { return .empty() }
            return strongSelf.repository
                .journeyExists(name: name)
                .map { !$0 }
        }

        let nameError = Observable.combineLatest(lengthValidator, uniqueValidator)
            .map { lengthValidator, isUnique -> String in
                if let error = lengthValidator.error {
                    return error
                } else if !isUnique {
                    return Literals.Name.Error.alreadyExists
                }
                return ""
            }
            .asDriver()

        let canSave = nameError.map { $0.isEmpty }

        let participantName = input.participantName.distinctUntilChanged().asObservable()
        let participantLengthValidator = participantName.map { [weak self] name -> ValidationResult in
            guard let strongSelf = self else { return .success }
            return strongSelf.validatorProvider.participantNameValidator.validate(text: name)
        }

        let participantUniqueValidator = Observable.combineLatest(participantName, participants) { name, items -> ValidationResult in
                let isUnique = items.first(where: { $0.text == name }) == nil
                return isUnique ? .success : .failure(message: "Not unique")
            }

        let validationResult = Observable.combineLatest(participantLengthValidator, participantUniqueValidator) {
        [$0, $1].first(where: { validator in !validator.isSuccess })?.error ?? ""
        }

        let addParticipant = input.addParticipant
            .asObservable()
            .withLatestFrom(participantName) { _, name -> Void  in
                participants.accept(participants.value + [.deletable(viewModel: .init(uuid: UUID().uuidString,
                                                                                      text: name,
                                                                                      disabled: false))])
            }

        let addParticipantEnabled = validationResult.map { $0.isEmpty }.asDriver()

        let dismiss = Driver.of(input.save, input.cancel)
            .merge()
            .do(onNext: { [weak self] _ in self?.coordinator.didFinish() })

        return Output(canSave: canSave,
                      nameError: nameError,
                      dismiss: dismiss,
                      participants: participants.asDriver(),
                      addParticipant: addParticipant.asDriver(),
                      addParticipantError: validationResult.asDriver(),
                      addParticipantEnabled: addParticipantEnabled)
        }
}

extension JourneyCreateViewModel {
    struct Input {
        let save: Driver<Void>
        let cancel: Driver<Void>
        let name: Driver<String>
        let participantName: Driver<String>
        let addParticipant: Driver<Void>
    }

    struct Output {
        let canSave: Driver<Bool>
        let nameError: Driver<String>
        let dismiss: Driver<Void>
        let participants: Driver<[TagViewItem]>
        let addParticipant: Driver<Void>
        let addParticipantError: Driver<String>
        let addParticipantEnabled: Driver<Bool>
    }
}
