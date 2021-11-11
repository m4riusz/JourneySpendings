//
//  EmptyViewCellViewModel.swift
//  Core
//
//  Created by Mariusz Sut on 01/10/2021.
//

import Foundation
import RxDataSources
import UIKit

public struct EmptyViewCellViewModel {
    public let image: UIImage
    public let title: String
    public let description: String

    public init(image: UIImage, title: String, description: String) {
        self.image = image
        self.title = title
        self.description = description
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
