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
    private typealias Literals = Assets.Strings.Journey.Details
    private lazy var contentView = UIView()
    private lazy var tagView = TagView(layout: layoutFactory.scrolableTagView(itemSpacing: Spacings.normal))
    private lazy var collectionView = UICollectionView(layout: layoutFactory.tableView())
    private lazy var expenseHeader = JourneyExpenseHeaderView()
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
        let addExpense = expenseHeader.actionTap.mapToVoid().asDriver()

        let output = viewModel.transform(input: .init(load: loadTrigger, currentFilter: itemSelected, addExpense: addExpense))

        output.items
            .drive(collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        output.journeyName
            .drive(rx.title)
            .disposed(by: disposeBag)

        output.participantFilters
            .drive(tagView.rx.items)
            .disposed(by: disposeBag)

        output.addResult
            .drive()
            .disposed(by: disposeBag)
    }

    private func setupView() {
        view.addSubview(contentView)
        view.backgroundColor = Assets.Colors.Core.Background.primary
        collectionView.registerHeader(Section.self)
        collectionView.register(EmptyViewCell.self)
        collectionView.register(JourneyExpenseCell.self)
        expenseHeader.title = Literals.Expense.title
        expenseHeader.action = Literals.Expense.add
        contentView.addSubview(tagView)
        contentView.addSubview(expenseHeader)
        contentView.addSubview(collectionView)
        contentView.snp.makeConstraints { $0.edges.equalTo(view.safeAreaLayoutGuide.snp.edges) }

        tagView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        expenseHeader.snp.makeConstraints { make in
            make.top.equalTo(tagView.snp.bottom).offset(Spacings.small)
            make.left.equalToSuperview().offset(Spacings.normal)
            make.right.equalToSuperview().offset(-Spacings.normal)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(expenseHeader.snp.bottom).offset(Spacings.small)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

fileprivate extension JourneyDetailsViewController {
    var dataSource: RxCollectionViewSectionedAnimatedDataSource<SectionViewModel<JourneyDetailsListItem>> {
        RxCollectionViewSectionedAnimatedDataSource(
            configureCell: { _, collectionView, indexPath, item in
                switch item {
                case .expense(let viewModel):
                    let cell = collectionView.dequeueCell(JourneyExpenseCell.self, indexPath: indexPath)
                    cell.load(viewModel: viewModel)
                    return cell
                case .empty(let viewModel):
                    let cell = collectionView.dequeueCell(EmptyViewCell.self, indexPath: indexPath)
                    cell.load(viewModel: viewModel)
                    return cell
                }
            }, configureSupplementaryView: { dataSource, collectionView, _, indexPath in
                let cell = collectionView.dequeueHeader(Section.self, indexPath: indexPath)
                cell.load(viewModel: dataSource.sectionModels[indexPath.section])
                return cell
            })
    }
}
