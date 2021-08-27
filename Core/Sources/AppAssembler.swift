//
//  AppAssembler.swift
//  Core
//
//  Created by Mariusz Sut on 14/08/2021.
//

import Swinject

public protocol AppAssembler {
    var container: Container { get }
    var assemblies: [ModuleAssembly] { get }
    func assembly()
}
