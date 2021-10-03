//
//  JourneysRepositoryProtocol.swift
//  Journey
//
//  Created by Mariusz Sut on 28/09/2021.
//

import Core
import RxSwift

protocol JourneysRepositoryProtocol {
    func getCurrentJourneys() -> Observable<[Journey]>
}
