//
//  CurrencyRepositoryProtocol.swift
//  Core
//
//  Created by Sut, Mariusz, (mBank/DBI) on 23/12/2021.
//

import RxSwift

public protocol CurrencyRepositoryProtocol {
    func getCurrencies() -> Observable<[Currency]>
}
