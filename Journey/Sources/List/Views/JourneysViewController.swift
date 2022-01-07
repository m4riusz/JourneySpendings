//
//  JourneysViewController.swift
//  Journey
//
//  Created by Mariusz Sut on 08/08/2021.
//

import UIKit
import Core
import RxSwift
import RxCocoa
import RxDataSources
import SnapKit

final class JourneysViewController: UIViewController {
    private lazy var collectionView = UICollectionView(layout: layoutFactory.tableView())
    private lazy var disposeBag = DisposeBag()
    private lazy var createJourneyButton = UIBarButtonItem(.add)
    var viewModel: JourneysViewModel!
    var layoutFactory: CompositionalLayoutFactoryProtocol!
    
    override func viewDidLoad() {
        setupView()
        bindViewModel()
    }

    private func bindViewModel() {
        let loadTrigger = rx.methodInvoked(#selector(viewWillAppear))
            .mapToVoid()
            .asDriver()

        let createJourney = createJourneyButton.rx.tap.mapToVoid().asDriver()
        let details = collectionView.rx.modelSelected(JourneysListItem.self)
            .compactMap { item -> String? in
                guard case let .journey(cellViewModel) = item else { return nil }
                return cellViewModel.uuid
            }
            .asDriver()
        let output = viewModel.transform(input: .init(load: loadTrigger,
                                                      createJournerTrigger: createJourney,
                                                      detailsTriger: details))
        output.items.drive(collectionView.rx.items(dataSource: RxCollectionViewSectionedAnimatedDataSource(
            configureCell: { _, collectionView, indexPath, item in
                switch item {
                case .journey(let viewModel):
                    let cell = collectionView.dequeueCell(JourneyItemCell.self, indexPath: indexPath)
                    cell.load(viewModel: viewModel)
                    return cell
                case .empty(let viewModel):
                    let cell = collectionView.dequeueCell(EmptyViewCell.self, indexPath: indexPath)
                    cell.load(viewModel: viewModel)
                    return cell
                }
            }, configureSupplementaryView: { dataSource, collectionView, _, indexPath in
                let header = collectionView.dequeueHeader(Section.self, indexPath: indexPath)
                header.load(viewModel: dataSource[indexPath.section])
                return header
            })))
            .disposed(by: disposeBag)
        output.details
            .drive()
            .disposed(by: disposeBag)

        output.createJourney
            .drive()
            .disposed(by: disposeBag)
    }

    private func setupView() {
        title = Assets.Strings.Journey.List.title
        view.addSubview(collectionView)
        navigationItem.rightBarButtonItem = createJourneyButton
        collectionView.backgroundColor = Assets.Colors.Core.Background.primary
        collectionView.register(JourneyItemCell.self)
        collectionView.register(EmptyViewCell.self)
        collectionView.registerHeader(Section.self)
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
