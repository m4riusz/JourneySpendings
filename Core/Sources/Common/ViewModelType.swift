//
//  ViewModelType.swift
//  Core
//
//  Created by Mariusz Sut on 25/09/2021.
//

import Foundation

public protocol ViewModelType {
    associatedtype Input
    associatedtype Output

    func transform(input: Input) -> Output
}
