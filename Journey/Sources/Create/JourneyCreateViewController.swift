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
    private typealias Literals = Assets.Strings.Journey.Create
    private lazy var cancelButton = UIBarButtonItem(.cancel)
    private lazy var saveButton = UIBarButtonItem(.save)
    private lazy var disposeBag = DisposeBag()
    private lazy var scrollView = UIScrollView()
    private lazy var contentView = UIView()
    private lazy var nameTextField = TextField()
    var viewModel: JourneyCreateViewModel!

    override func viewDidLoad() {
        setupView()
        bindViewModel()
    }

    private func bindViewModel() {
        let name = nameTextField.rx.text.orEmpty.asDriver()
        let cancel = cancelButton.rx.tap.asDriver()
        let save = saveButton.rx.tap.asDriver()
        let output = viewModel.transform(input: .init(save: save, cancel: cancel, name: name))

        output.nameError
            .drive(nameTextField.rx.error)
            .disposed(by: disposeBag)

        output.dismiss
            .drive()
            .disposed(by: disposeBag)

        output.canSave
            .drive(saveButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }

    private func setupView() {
        title = Literals.title
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = saveButton
        view.backgroundColor = Assets.Colors.Core.Background.primary
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(nameTextField)
        nameTextField.titleText = Literals.Name.title
        nameTextField.placeholder = Literals.Name.placeholder
        nameTextField.helperText = Literals.Name.helper

        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }

        nameTextField.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(Spacings.normal)
            make.left.equalToSuperview().offset(Spacings.normal)
            make.right.equalToSuperview().offset(-Spacings.normal)
            make.bottom.equalToSuperview().offset(-Spacings.normal)
        }
    }
}
