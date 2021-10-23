//
//  JourneysRepository.swift
//  Journey
//
//  Created by Mariusz Sut on 28/09/2021.
//

import Core
import RxSwift
import Foundation

final class JourneysRepository: JourneysRepositoryProtocol {
    func journeyExists(name: String) -> Observable<Bool> {
        .just(name == "123456")
    }

    // TODO: - add real implementation
    func getCurrentJourneys() -> Observable<[Journey]> {
        .just([.init(uuid: "1", name: "Bieszczady", startDate: Date(), totalCost: 100, currency: "zł"),
               .init(uuid: "2", name: "Szczecin", startDate: Date(), totalCost: 123, currency: "zł"),
               .init(uuid: "3", name: "Wadowice", startDate: Date(), totalCost: 2137, currency: "zł")])

    }
}
