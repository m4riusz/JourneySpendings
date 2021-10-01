//
//  EmptyViewCellViewModel.swift
//  Core
//
//  Created by Mariusz Sut on 01/10/2021.
//

import Foundation
import RxDataSources

public struct EmptyViewCellViewModel {
    public let title: String
    public let description: String
    public let buttonText: String

    public init(title: String, description: String, buttonText: String) {
        self.title = title
        self.description = description
        self.buttonText = buttonText
    }
}

// MARK: - Equatable
extension EmptyViewCellViewModel: Equatable { /*Nop*/ }

// MARK: - IdentifiableType
extension EmptyViewCellViewModel: IdentifiableType {
    public var identity: String {
        "\(title)\(description)"
    }
}
