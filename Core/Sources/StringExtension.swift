//
//  StringExtension.swift
//  Core
//
//  Created by Mariusz Sut on 14/08/2021.
//

import Foundation

public extension String {
    static func localized(_ table: String, _ key: String) -> String {
        NSLocalizedString(key, tableName: table, comment: "")
    }
}
