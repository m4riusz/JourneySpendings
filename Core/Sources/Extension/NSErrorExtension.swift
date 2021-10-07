//
//  NSErrorExtension.swift
//  Core
//
//  Created by Mariusz Sut on 07/10/2021.
//

import Foundation

public extension NSError {
    static let `internal` = NSError(message: "internal")

    convenience init(domain: String = "pl.msut.error", code: Int = 0, message: String) {
        self.init(domain: domain, code: code, userInfo: [ NSLocalizedDescriptionKey: message ])
    }
}
