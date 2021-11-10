//
//  GRDBRepresentable.swift
//  Core
//
//  Created by Mariusz Sut on 10/11/2021.
//

import Foundation

protocol GRDBRepresentable {
    associatedtype GRDBType: DomainConvertibleType

    var asGRDB: GRDBType { get}
}
