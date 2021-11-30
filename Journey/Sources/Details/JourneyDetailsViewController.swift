//
//  JourneyDetailsViewController.swift
//  Journey
//
//  Created by Mariusz Sut on 16/11/2021.
//

import RxSwift
import RxCocoa
import UIKit
import Core
import RxDataSources

final class JourneyDetailsViewController: UIViewController {
    private lazy var contentView = UIView()
    private lazy var tagView = TagView(layout: layoutFactory.scrolableTagView(itemSpacing: Spacings.normal))
    private lazy var collectionView = UICollectionView(layout: layoutFactory.tableView())
    private lazy var disposeBag = DisposeBag()
    var viewModel: JourneyDetailsViewModel!
    var layoutFactory: CompositionalLayoutFactoryProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindViewModel()
    }

    private func bindViewModel() {
        let loadTrigger = rx.methodInvoked(#selector(viewWillAppear))
            .mapToVoid()
            .asDriver()

        let itemSelected = tagView.rx.selectTagEvent.asDriver()

        let output = viewModel.transform(input: .init(load: loadTrigger, currentFilter: itemSelected))
        
        output.items.drive(collectionView.rx.items(dataSource: RxCollectionViewSectionedAnimatedDataSource(
            configureCell: { _, collectionView, indexPath, item in
                switch item {
                case .expenses:
                    return collectionView.dequeueCell(EmptyViewCell.self, indexPath: indexPath)
                }
            }, configureSupplementaryView: { dataSource, collectionView, _, IndexPath in
                let cell = collectionView.dequeueHeader(Section.self, indexPath: IndexPath)
                cell.load(viewModel: dataSource.sectionModels[IndexPath.row])
                return cell
            })))
            .disposed(by: disposeBag)

        output.journeyName
            .drive(rx.title)
            .disposed(by: disposeBag)

        output.participantFilters
            .drive(tagView.rx.items)
            .disposed(by: disposeBag)
    }

    private func setupView() {
        view.addSubview(contentView)
        view.backgroundColor = Assets.Colors.Core.Background.primary
        collectionView.registerHeader(Section.self)
        collectionView.register(EmptyViewCell.self)
        contentView.addSubview(tagView)
        contentView.addSubview(collectionView)
        contentView.snp.makeConstraints { $0.edges.equalTo(view.safeAreaLayoutGuide.snp.edges) }
        tagView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(tagView.snp.bottom).offset(Spacings.small)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
