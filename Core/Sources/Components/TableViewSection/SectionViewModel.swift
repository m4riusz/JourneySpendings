//
//  SectionViewModel.swift
//  Core
//
//  Created by Sut, Mariusz, (mBank/DBI) on 29/11/2021.
//

import Foundation
import RxDataSources

public struct SectionViewModel<T: IdentifiableType & Equatable> {
    public let title: String
    public let button: String?
    public var items: [T]
    
    public init(title: String, button: String? = nil, items: [T] = []) {
        self.title = title
        self.button = button
        self.items = items
    }
    
    public init(items: [T]) {
        self.init(title: "", items: items)
    }
}

// MARK: - Equatable
extension SectionViewModel: Equatable { /*Nop*/ }

// MARK: - AnimatableSectionModelType
extension SectionViewModel: AnimatableSectionModelType {
    public typealias Item = T

    public var identity: String {
        title
    }

    public init(original: SectionViewModel, items: [T]) {
        self = original
        self.items = items
    }
}

// MARK: - SectionProtocol
extension SectionViewModel: SectionProtocol { /*Nop*/ }
