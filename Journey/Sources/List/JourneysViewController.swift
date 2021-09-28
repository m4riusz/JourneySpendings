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
                let cell = tableView.dequeueCell(JourneyItemCell.self, indexPath: indexPath)
                cell.load(viewModel: item)
                return cell
            }, titleForHeaderInSection: { dataSource, section in
                dataSource.sectionModels[section].title
            })))
            .disposed(by: disposeBag)

        output.items
            .drive()
            .disposed(by: disposeBag)
    }

    private func setupView() {
        title = Assets.Strings.Journey.journeyListTitle
        view.addSubview(tableView)
        tableView.register(JourneyItemCell.self)
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
