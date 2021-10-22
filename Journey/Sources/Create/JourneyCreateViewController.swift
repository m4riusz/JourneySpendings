//
//  JourneyCreateViewController.swift
//  Journey
//
//  Created by Mariusz Sut on 19/10/2021.
//

import UIKit
import RxSwift
import Core
import RxDataSources

final class JourneyCreateViewController: UIViewController {
    private lazy var disposeBag = DisposeBag()
    private lazy var tableView = UITableView()
    var viewModel: JourneyCreateViewModel!

    override func viewDidLoad() {
        setupView()
        bindViewModel()
    }

    private func bindViewModel() {
        let output = viewModel.transform(input: .init())

        output.items.drive(tableView.rx.items(dataSource: RxTableViewSectionedAnimatedDataSource(
            configureCell: { _, tableView, indexPath, item in
                switch item {
                case .name(let viewModel):
                    let cell = tableView.dequeueCell(TextFieldCell.self, indexPath: indexPath)
                    cell.load(viewModel: viewModel)
                    return cell
                }
            }
        ))).disposed(by: disposeBag)
    }

    private func setupView() {
        view.backgroundColor = Assets.Colors.Core.Background.primary
        view.addSubview(tableView)
        tableView.register(TextFieldCell.self)
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
