//
//  DomainConvertibleType.swift
//  Core
//
//  Created by Mariusz Sut on 10/11/2021.
//

import Foundation

protocol DomainConvertibleType {
    associatedtype DomainType

    var asDomain: DomainType { get }
}
