//
//  TagViewExtension.swift
//  Core
//
//  Created by Mariusz Sut on 07/11/2021.
//

import RxSwift
import RxCocoa

public extension Reactive where Base: TagView {
    var deleteTagEvent: ControlEvent<String> {
        ControlEvent<String>(events: base.deleteItemSubject)
    }
}
