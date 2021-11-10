//
//  JourneysRepositoryProtocol.swift
//  Core
//
//  Created by Mariusz Sut on 28/09/2021.
//

import RxSwift

public protocol JourneysRepositoryProtocol {
    func create(name: String) -> Observable<Void>
    func journeyExists(name: String) -> Observable<Bool>
    func getCurrentJourneys() -> Observable<[Journey]>
}
