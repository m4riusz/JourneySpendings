//
//  ModuleAssembly.swift
//  Core
//
//  Created by Mariusz Sut on 14/08/2021.
//

import Swinject

public protocol ModuleAssembly {
    func register(container: Container)
}
