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
    private let coordinator = JourneysCoordinatorSpy()
    private lazy var sut: JourneysViewModel = {
        let viewModel = JourneysViewModel(repository: repository)
        viewModel.coordinator = coordinator
        return viewModel
    }()
    private lazy var scheduler = TestScheduler(initialClock: .zero)
    private var bag = DisposeBag()

    func testLoadNoItems() {
        repository.getCurrentJourneysResult = .just([])
        let loadEvent = PublishSubject<Void>()
        let createJourneyTrigger = PublishSubject<Void>()
        let details = PublishSubject<String>()
        let output = sut.transform(input: .init(load: loadEvent.asDriver(),
                                                createJournerTrigger: createJourneyTrigger.asDriver(),
                                                detailsTriger: details.asDriver()))
        let itemsObserver = scheduler.createObserver([Section<JourneysListItem>].self)

        let expectedItems: [Recorded<Event<[Section<JourneysListItem>]>>] = [
            .next(100, [.init(items: [.empty(viewModel: .init(image: CoreImages.bagSuitcaseOutline,
                                                              title: Literals.title,
                                                              description: Literals.descrption))])])
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
                                                           currency: "zł",
                                                           participants: [])])
        let loadEvent = PublishSubject<Void>()
        let createJourneyTrigger = PublishSubject<Void>()
        let details = PublishSubject<String>()
        let output = sut.transform(input: .init(load: loadEvent.asDriver(),
                                                createJournerTrigger: createJourneyTrigger.asDriver(),
                                                detailsTriger: details.asDriver()))
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
        repository.getCurrentJourneysResult = .error(NSError.internal)
        let loadEvent = PublishSubject<Void>()
        let createJourneyTrigger = PublishSubject<Void>()
        let details = PublishSubject<String>()
        let output = sut.transform(input: .init(load: loadEvent.asDriver(),
                                                createJournerTrigger: createJourneyTrigger.asDriver(),
                                                detailsTriger: details.asDriver()))
        let itemsObserver = scheduler.createObserver([Section<JourneysListItem>].self)

        let expectedItems: [Recorded<Event<[Section<JourneysListItem>]>>] = [
            .next(100, [.init(items: [.empty(viewModel: .init(image: CoreImages.bagSuitcaseOutline,
                                                              title: Literals.title,
                                                              description: Literals.descrption))])])
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

    func testNavigation() {
        repository.getCurrentJourneysResult = .error(NSError.internal)
        let loadEvent = PublishSubject<Void>()
        let createJourneyTrigger = PublishSubject<Void>()
        let details = PublishSubject<String>()
        let output = sut.transform(input: .init(load: loadEvent.asDriver(),
                                                createJournerTrigger: createJourneyTrigger.asDriver(),
                                                detailsTriger: details.asDriver()))

        scheduler.scheduleAt(.zero) {
            output.items
                .drive()
                .disposed(by: self.bag)
            output.createJourney
                .drive()
                .disposed(by: self.bag)
        }

        scheduler.scheduleAt(100) {
            loadEvent.on(.next(()))
            createJourneyTrigger.on(.next(()))
        }
        scheduler.start()
        XCTAssertEqual(coordinator.toCreateFormCallCout, 1)
    }
}
