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

final class JourneyDetailsViewController: UIViewController {
    private lazy var contentView = UIView()
    private lazy var tagView = TagView(layout: layoutFactory.scrolableTagView(itemSpacing: Spacings.normal))
    private lazy var tableView = UITableView()
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
        tableView.registerHeaderFooter(TableViewSection.self)
        contentView.addSubview(tagView)
        contentView.addSubview(tableView)
        contentView.snp.makeConstraints { $0.edges.equalTo(view.safeAreaLayoutGuide.snp.edges) }
        tagView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(tagView.snp.bottom).offset(Spacings.small)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
