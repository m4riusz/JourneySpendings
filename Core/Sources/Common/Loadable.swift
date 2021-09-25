//
//  Loadable.swift
//  Core
//
//  Created by Mariusz Sut on 25/09/2021.
//

import Foundation

public protocol Loadable {
    associatedtype ViewModel

    func load(viewModel: ViewModel)
}
