//
//  JourneysRepositoryProtocol.swift
//  Journey
//
//  Created by Mariusz Sut on 28/09/2021.
//

import Core
import RxSwift

protocol JourneysRepositoryProtocol {
    func journeyExists(name: String) -> Observable<Bool>
    func getCurrentJourneys() -> Observable<[Journey]>
}
