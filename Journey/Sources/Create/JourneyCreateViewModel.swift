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
    struct Input {
        let save: Driver<Void>
        let cancel: Driver<Void>
        let name: Driver<String>
    }

    struct Output {
        let canSave: Driver<Bool>
        let nameError: Driver<String>
        let dismiss: Driver<Void>
    }

    private let repository: JourneysRepositoryProtocol
    var coordinator: JourneyCreateCoordinatorProtocol!

    init(repository: JourneysRepositoryProtocol) {
        self.repository = repository
    }

    func transform(input: Input) -> Output {
        let name = input.name.distinctUntilChanged().asObservable()
        let lengthValidator = name.map { $0.count >= 4 }
        let uniqueValidator = name.flatMapLatest { [weak self] name -> Observable<Bool> in
            guard let strongSelf = self else { return .empty() }
            return strongSelf.repository
                .journeyExists(name: name)
                .map { !$0 }
        }

        let nameError = Observable.combineLatest(lengthValidator, uniqueValidator)
            .map { hasValidLength, isUnique -> String in
                if !hasValidLength {
                    return Literals.Name.Error.toShort
                } else if !isUnique {
                    return Literals.Name.Error.alreadyExists
                }
                return ""
            }
            .asDriver()

        let canSave = nameError.map { $0.isEmpty }

        let dismiss = Driver.of(input.save, input.cancel)
            .merge()
            .do(onNext: { [weak self] _ in self?.coordinator.didFinish() })

        return Output(canSave: canSave,
                      nameError: nameError,
                      dismiss: dismiss)
        }
}
