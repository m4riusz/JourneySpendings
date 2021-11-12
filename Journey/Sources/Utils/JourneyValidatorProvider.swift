//
//  JourneyValidatorProvider.swift
//  Journey
//
//  Created by Mariusz Sut on 23/10/2021.
//

import Core

protocol JourneyValidatorProviderProtocol {
    var journeyNameValidator: ValidatorProtocol { get }
    func participantNameValidator(participants: [String]) -> ValidatorProtocol
}

struct JourneyValidatorProvider: JourneyValidatorProviderProtocol {
    private typealias Literals = Assets.Strings.Journey.Create
    struct Constants {
        struct Journey {
            static let minLengthName: UInt = 4
            static let maxLengthName: UInt = 40
        }
        struct Participant {
            static let minLengthName: UInt = 2
            static let maxLengthName: UInt = 30
        }
    }

    var journeyNameValidator: ValidatorProtocol {
        CompoundValidator(validators: [
            MinimumLengthValidator(minimumLength: Constants.Journey.minLengthName,
                                   errorMessage: Literals.Name.Error.tooShort),
            MaximumLengthValidator(maximumLength: Constants.Journey.maxLengthName,
                                   errorMessage: Literals.Name.Error.tooLong)
        ])
    }

    func participantNameValidator(participants: [String]) -> ValidatorProtocol {
        CompoundValidator(validators: [
            MinimumLengthValidator(minimumLength: Constants.Participant.minLengthName,
                                   errorMessage: Literals.People.Name.Error.tooShort),
            MaximumLengthValidator(maximumLength: Constants.Participant.maxLengthName,
                                   errorMessage: Literals.People.Name.Error.tooLong),
            UniqueStringValidator(strings: participants,
                                  errorMessage: Literals.People.Name.Error.alreadyExists)
        ])
    }
}
