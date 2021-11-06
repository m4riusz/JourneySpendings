//
//  BehaviorRelayExtension.swift
//  Core
//
//  Created by Mariusz Sut on 06/11/2021.
//

import RxSwift
import RxCocoa

public extension BehaviorRelay where Element: RangeReplaceableCollection {

    func append(_ element: Element.Element) {
        var array = value
        array.append(element)
        accept(array)
    }
}
