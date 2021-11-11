//
//  ArrayExtension.swift
//  Core
//
//  Created by Mariusz Sut on 11/11/2021.
//

import Foundation

extension Array {
    mutating func mutateEach(by transform: (inout Element) throws -> Void) rethrows {
        self = try map { el in
            var el = el
            try transform(&el)
            return el
        }
     }
}
