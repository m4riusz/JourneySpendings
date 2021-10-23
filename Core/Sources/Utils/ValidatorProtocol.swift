//
//  ValidatorProtocol.swift
//  Core
//
//  Created by Mariusz Sut on 23/10/2021.
//

import Foundation

public enum ValidationResult: Equatable {
    case success
    case failure(message: String)

    public var isSuccess: Bool {
        switch self {
        case .success: return true
        case .failure: return false
        }
    }

    public var error: String? {
        switch self {
        case .success: return nil
        case .failure(let message): return message
        }
    }
}

public protocol ValidatorProtocol {
    func validate(text: String) -> ValidationResult
}
