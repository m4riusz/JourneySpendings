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
    private lazy var tagView = TagView(layout: layoutFactory.tagView(itemSpacing: Spacings.normal))
    private lazy var participantTextField = TextField()
    private lazy var participantAddButton = Button()
    var viewModel: JourneyCreateViewModel!
    var layoutFactory: CompositionalLayoutFactoryProtocol!

    override func viewDidLoad() {
        setupView()
        bindViewModel()
    }

    private func bindViewModel() {
        let name = nameTextField.rx.text.orEmpty.asDriver()
        let cancel = cancelButton.rx.tap.asDriver()
        let save = saveButton.rx.tap.asDriver()
        let participantName = participantTextField.rx.text.orEmpty.asDriver()
        let addParticipant = participantAddButton.rx.tap.asDriver()

        let output = viewModel.transform(input: .init(save: save,
                                                      cancel: cancel,
                                                      name: name,
                                                      participantName: participantName,
                                                      addParticipant: addParticipant))

        output.nameError
            .drive(nameTextField.rx.error)
            .disposed(by: disposeBag)

        output.dismiss
            .drive()
            .disposed(by: disposeBag)

        output.participants
            .drive(onNext: { [weak self] participants in
                self?.tagView.items = participants
            })
            .disposed(by: disposeBag)

        output.canSave
            .drive(saveButton.rx.isEnabled)
            .disposed(by: disposeBag)

        output.addParticipant
            .drive()
            .disposed(by: disposeBag)

        output.addParticipantError
            .drive(participantTextField.rx.error)
            .disposed(by: disposeBag)

        output.addParticipantEnabled
            .drive(participantAddButton.rx.isEnabled)
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
        contentView.addSubview(tagView)
        contentView.addSubview(participantTextField)
        contentView.addSubview(participantAddButton)
        nameTextField.titleText = Literals.Name.title
        nameTextField.placeholder = Literals.Name.placeholder
        nameTextField.helperText = Literals.Name.helper
        tagView.titleText = Literals.People.title
        tagView.helperText = Literals.People.helper
        tagView.items = []
        tagView.addButtonVisible = false
        participantTextField.placeholder = "Uczestnik"
        participantTextField.helperText = "Więcej niż 2 znaki"
        participantAddButton.text = "Dodaj"
        participantAddButton.style = .tertiary

        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }

        nameTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Spacings.normal)
            make.left.equalToSuperview().offset(Spacings.normal)
            make.right.equalToSuperview().offset(-Spacings.normal)
        }

        tagView.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(Spacings.normal)
            make.left.equalToSuperview().offset(Spacings.normal)
            make.right.equalToSuperview().offset(-Spacings.normal)
        }

        participantTextField.snp.makeConstraints { make in
            make.top.equalTo(tagView.snp.bottom).offset(Spacings.normal)
            make.left.equalToSuperview().offset(Spacings.normal)
            make.bottom.equalToSuperview().offset(-Spacings.normal)
        }

        participantAddButton.snp.makeConstraints { make in
            make.top.equalTo(tagView.snp.bottom).offset(Spacings.normal)
            make.left.equalTo(participantTextField.snp.right).offset(Spacings.normal)
            make.right.equalToSuperview().offset(-Spacings.normal)
            make.bottom.lessThanOrEqualToSuperview().offset(-Spacings.normal)
        }
        participantAddButton.setContentHuggingPriority(.required, for: .horizontal)
        participantAddButton.setContentCompressionResistancePriority(.required, for: .horizontal)
    }
}
