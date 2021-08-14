//
//  StringExtension.swift
//  JourneySpendings
//
//  Created by Mariusz Sut on 14/08/2021.
//

import Foundation

extension String {
    func localized(_ table: String, _ key: String) -> String {
        NSLocalizedString(key, tableName: table, comment: "")
    }
}
