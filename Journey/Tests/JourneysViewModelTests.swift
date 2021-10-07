//
//  JourneysViewModelTests.swift
//  JourneyTests
//
//  Created by Mariusz Sut on 03/09/2021.
//

import Core
import XCTest
import RxTest
import RxSwift
@testable import Journey

final class JourneysViewModelTests: XCTestCase {
    private typealias CoreImages = Assets.Images.Core
    private typealias Literals = Assets.Strings.Journey.List.Empty
    private let repository = JourneysRepositoryMock()
    private lazy var sut = JourneysViewModel(repository: repository)
    private lazy var scheduler = TestScheduler(initialClock: .zero)
    private var bag = DisposeBag()

    func testLoadNoItems() {
        repository.getCurrentJourneysResult = .just([])
        let loadEvent = PublishSubject<Void>()
        let output = sut.transform(input: JourneysViewModel.Input(load: loadEvent.asDriver()))
        let itemsObserver = scheduler.createObserver([Section<JourneysListItem>].self)

        let expectedItems: [Recorded<Event<[Section<JourneysListItem>]>>] = [
            .next(100, [.init(items: [.empty(viewModel: .init(image: CoreImages.bagSuitcaseOutline,
                                                              title: Literals.title,
                                                              description: Literals.descrption,
                                                              buttonText: Literals.action))])])
        ]
        scheduler.scheduleAt(.zero) {
            output.items
                .drive(itemsObserver)
                .disposed(by: self.bag)
        }

        scheduler.scheduleAt(100) {
            loadEvent.on(.next(()))
        }
        scheduler.start()
        XCTAssertEqual(expectedItems, itemsObserver.events)
    }

    func testLoadSomeItems() {
        repository.getCurrentJourneysResult = .just([.init(uuid: "1",
                                                           name: "Name",
                                                           startDate: Date.from(year: 2000, month: 1, day: 1),
                                                           totalCost: 100,
                                                           currency: "zł")])
        let loadEvent = PublishSubject<Void>()
        let output = sut.transform(input: JourneysViewModel.Input(load: loadEvent.asDriver()))
        let itemsObserver = scheduler.createObserver([Section<JourneysListItem>].self)

        let expectedItems: [Recorded<Event<[Section<JourneysListItem>]>>] = [
            .next(100, [.init(items: [.journey(viewModel: .init(uuid: "1",
                                                                name: "Name",
                                                                startDate: "01-01-2000",
                                                                totalCost: "100,00 zł"))])])
        ]
        scheduler.scheduleAt(.zero) {
            output.items
                .drive(itemsObserver)
                .disposed(by: self.bag)
        }

        scheduler.scheduleAt(100) {
            loadEvent.on(.next(()))
        }
        scheduler.start()
        XCTAssertEqual(expectedItems, itemsObserver.events)
    }

    func testLoadError() {
        repository.getCurrentJourneysResult = .error(NSError(domain: "", code: 1, userInfo: nil))
        let loadEvent = PublishSubject<Void>()
        let output = sut.transform(input: JourneysViewModel.Input(load: loadEvent.asDriver()))
        let itemsObserver = scheduler.createObserver([Section<JourneysListItem>].self)

        let expectedItems: [Recorded<Event<[Section<JourneysListItem>]>>] = [
            .next(100, [.init(items: [.empty(viewModel: .init(image: CoreImages.bagSuitcaseOutline,
                                                              title: Literals.title,
                                                              description: Literals.descrption,
                                                              buttonText: Literals.action))])])
        ]
        scheduler.scheduleAt(.zero) {
            output.items
                .drive(itemsObserver)
                .disposed(by: self.bag)
        }

        scheduler.scheduleAt(100) {
            loadEvent.on(.next(()))
        }
        scheduler.start()
        XCTAssertEqual(expectedItems, itemsObserver.events)
    }
}
