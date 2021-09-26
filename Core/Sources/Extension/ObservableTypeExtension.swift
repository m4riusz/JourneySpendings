//
//  ObservableTypeExtension.swift
//  Core
//
//  Created by Mariusz Sut on 26/09/2021.
//

import RxSwift
import RxCocoa

public extension ObservableType {
    func mapToVoid() -> Observable<Void> {
        map { _ in }
    }

    func asDriver() -> Driver<Element> {
        asDriver { _ in .empty() }
    }
}
