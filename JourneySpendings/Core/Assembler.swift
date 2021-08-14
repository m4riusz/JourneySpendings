//
//  Assembler.swift
//  JourneySpendings
//
//  Created by Mariusz Sut on 14/08/2021.
//

import Swinject

protocol Assembler {
    var container: Container { get }
    var assemblies: [Assembly] { get }
    func assembly()
}
