//
//  CurrencyRepository.swift
//  Core
//
//  Created by Sut, Mariusz, (mBank/DBI) on 23/12/2021.
//

import RxSwift
import GRDB

final class CurrencyRepository: CurrencyRepositoryProtocol {
    private let databaseManager: DatabaseManagerProtocol
    private var dbQueue: DatabaseQueue { databaseManager.databaseQueue! }

    init(databaseManager: DatabaseManagerProtocol) {
        self.databaseManager = databaseManager
    }
    
    public func getCurrencies() -> Observable<[Currency]> {
        ValueObservation
            .tracking { try GRDBCurrency.fetchAll($0) }
            .rx
            .observe(in: dbQueue)
            .map { items in items.map { $0.asCurrency } }
    }
}

extension GRDBCurrency {
    var asCurrency: Currency {
        .init(uuid: uuid!,
              code: code,
              symbol: symbol)
    }
}
