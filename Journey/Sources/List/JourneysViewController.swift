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
import SnapKit

final class JourneysViewController: UIViewController {
    private lazy var tableView = UITableView()
    private lazy var disposeBag = DisposeBag()
    var viewModel: JourneysViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func bindViewModel() {
        let load = rx.methodInvoked(#selector(JourneysViewController.viewDidLoad))
            .mapToVoid()
            .asDriver()

        let output = viewModel.transform(input: .init(load: load))
//        output.items.drive(tableView.rx.items(dataSource: RxTableViewDataSourceType & UITableViewDataSource))
        output.items.drive().disposed(by: disposeBag)
    }

    private func setupView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

extension ObservableType {
    func mapToVoid() -> Observable<Void> {
        map { _ in }
    }

    func asDriver() -> Driver<Element> {
        asDriver { _ in .empty() }
    }
}
