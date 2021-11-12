//
//  StringRepresentable.swift
//  Core
//
//  Created by Mariusz Sut on 12/11/2021.
//

import Foundation

public protocol StringRepresentable {
    var string: String { get }
}

extension String: StringRepresentable {
    public var string: String { self }
}

extension Int: StringRepresentable {
    public var string: String { "\(self)" }
}

extension UInt: StringRepresentable {
    public var string: String { "\(self)" }
}

extension Float: StringRepresentable {
    public var string: String { "\(self)" }
}

extension Double: StringRepresentable {
    public var string: String { "\(self)" }
}
