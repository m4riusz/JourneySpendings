//
//  Section.swift
//  Core
//
//  Created by Mariusz Sut on 26/09/2021.
//

import RxDataSources

public struct Section<T: IdentifiableType & Equatable> {
    public var title: String
    public var items: [T]

    public init(items: [T]) {
        self.init(title: "", items: items)
    }

    public init(title: String, items: [T]) {
        self.title = title
        self.items = items
    }
}

// MARK: - Equatable
extension Section: Equatable { /*Nop*/ }

// MARK: - AnimatableSectionModelType
extension Section: AnimatableSectionModelType {
    public typealias Item = T

    public var identity: String {
        title
    }

    public init(original: Section, items: [T]) {
        self = original
        self.items = items
    }
}
