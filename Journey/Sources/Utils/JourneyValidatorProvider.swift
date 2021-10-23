//
//  JourneyValidatorProvider.swift
//  Journey
//
//  Created by Mariusz Sut on 23/10/2021.
//

import Core

protocol JourneyValidatorProviderProtocol {
    var journeyNameValidator: ValidatorProtocol { get }
}

struct JourneyValidatorProvider: JourneyValidatorProviderProtocol {
    private typealias Literals = Assets.Strings.Journey.Create
    private struct Constants {
        static let minLengthName: UInt = 4
        static let maxLengthName: UInt = 40
    }

    var journeyNameValidator: ValidatorProtocol {
        CompoundValidator(validators: [
            MinimumLengthValidator(minimumLength: Constants.minLengthName,
                                   errorMessage: Literals.Name.Error.tooShort),
            MaximumLengthValidator(maximumLength: Constants.maxLengthName,
                                   errorMessage: Literals.Name.Error.tooLong)
        ])
    }
}
