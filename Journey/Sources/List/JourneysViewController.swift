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
    private lazy var tableView = UITableView()
    private lazy var disposeBag = DisposeBag()
    var viewModel: JourneysViewModel!

    override func viewDidLoad() {
        setupView()
        bindViewModel()
    }

    private func bindViewModel() {
        let loadTrigger = rx.methodInvoked(#selector(viewWillAppear))
            .mapToVoid()
            .asDriver()

        let output = viewModel.transform(input: .init(load: loadTrigger))
        output.items.drive(tableView.rx.items(dataSource: RxTableViewSectionedAnimatedDataSource(
            configureCell: { _, tableView, indexPath, item in
                switch item {
                case .journey(let viewModel):
                    let cell = tableView.dequeueCell(JourneyItemCell.self, indexPath: indexPath)
                    cell.load(viewModel: viewModel)
                    return cell
                case .empty(let viewModel):
                    let cell = tableView.dequeueCell(EmptyViewCell.self, indexPath: indexPath)
                    cell.load(viewModel: viewModel)
                    return cell
                }
            }, titleForHeaderInSection: { dataSource, section in
                dataSource.sectionModels[section].title
            })))
            .disposed(by: disposeBag)

        output.items
            .drive()
            .disposed(by: disposeBag)
    }

    private func setupView() {
        title = Assets.Strings.Journey.List.title
        view.addSubview(tableView)
        tableView.backgroundColor = Assets.Colors.Core.Background.primary
        tableView.register(JourneyItemCell.self)
        tableView.register(EmptyViewCell.self)
        tableView.separatorStyle = .none
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
