//
//  TagView.swift
//  Core
//
//  Created by Mariusz Sut on 26/10/2021.
//

import UIKit
import RxCocoa
import RxSwift

final public class TagView: UIView {
    private typealias Colors = Assets.Colors.Core
    private typealias Images = Assets.Images.Core
    private struct Constants {
        static let titleLabelNumberOfLines = 1
        static let emptyLabelNumberOfLines = 1
        static let errorLabelNumberOfLines = 0
        static let helperLabelNumberOfLines = 0
        static let emptyViewHeight = 40
    }
    private lazy var titleLabel = UILabel()
    private lazy var addButton = UIButton()
    private lazy var emptyLabel = UILabel()
    private lazy var helperLabel = UILabel()
    private lazy var errorLabel = UILabel()
    private lazy var stackView = UIStackView()
    private let collectionView: UICollectionView
    lazy var deleteItemSubject = PublishSubject<String>()

    public var addButtonVisible = true {
        didSet { updateAddButtonVisibility() }
    }

    public var addButtonEnabled = true {
        didSet { addButton.isEnabled = addButtonEnabled }
    }

    public var titleText: String? {
        didSet {
            titleLabel.attributedText = titleText?.styled(.subhead, attributes: [.color(Colors.Label.secondary)])
            titleLabel.isHidden = titleText.isNilOrBlank
            updateAddButtonVisibility()
        }
    }

    public var helperText: String? {
        didSet {
            helperLabel.attributedText = helperText?.styled(.footnote)
            helperLabel.isHidden = helperText.isNilOrBlank
        }
    }

    public var emptyText: String? {
        didSet {
            emptyLabel.attributedText = emptyText?.styled(.body, attributes: [.alignment(.center)])
        }
    }

    public var errorText: String? {
        didSet {
            errorLabel.attributedText = errorText?.styled(.subhead, attributes: [.color(Colors.error)])
            errorLabel.isHidden = errorText.isNilOrBlank
        }
    }

    public var items: [TagViewItem] = [] {
        didSet {
            emptyLabel.isHidden = !items.isEmpty
            collectionView.isHidden = items.isEmpty
            collectionView.reloadData()
            layoutSubviews()
        }
    }

    public init(layout: UICollectionViewLayout) {
        collectionView = SelfSizingCollectionView(collectionViewLayout: layout)
        super.init(frame: .zero)
        commonInit()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("Coder not supported")
    }

    private func commonInit() {
        stackView.axis = .vertical
        stackView.distribution = .fill
        titleLabel.numberOfLines = Constants.titleLabelNumberOfLines
        addButton.setImage(Images.plus, for: .normal)
        addButton.tintColor = Colors.Action.primary
        addButton.setContentHuggingPriority(.required, for: .horizontal)
        addButton.setContentCompressionResistancePriority(.required, for: .horizontal)
        helperLabel.numberOfLines = Constants.helperLabelNumberOfLines
        emptyLabel.numberOfLines = Constants.emptyLabelNumberOfLines
        errorLabel.numberOfLines = Constants.errorLabelNumberOfLines
        collectionView.backgroundColor = .clear
        collectionView.register(DeletableTagViewCell.self)
        collectionView.dataSource = self
        collectionView.isScrollEnabled = false
        addSubview(stackView)
        let titleAndButtonStackView = UIStackView(arrangedSubviews: [titleLabel, addButton])
        titleAndButtonStackView.axis = .horizontal
        stackView.addArrangedSubview(titleAndButtonStackView)
        stackView.addArrangedSubview(emptyLabel)
        stackView.addArrangedSubview(collectionView)
        stackView.addArrangedSubview(errorLabel)
        stackView.addArrangedSubview(helperLabel)
        stackView.setCustomSpacing(Spacings.small, after: titleAndButtonStackView)
        stackView.setCustomSpacing(Spacings.small, after: collectionView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        emptyLabel.snp.makeConstraints { make in
            make.height.equalTo(Constants.emptyViewHeight)
        }
        collectionView.snp.makeConstraints { make in
            make.height.greaterThanOrEqualTo(1)
        }
    }

    private func updateAddButtonVisibility() {
        addButton.isHidden = titleText.isNilOrBlank || !addButtonVisible
    }
}

// MARK: - UICollectionViewDataSource
extension TagView: UICollectionViewDataSource {

    public func collectionView(_ collectionView: UICollectionView,
                               numberOfItemsInSection section: Int) -> Int {
        items.count
    }

    public func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch items[indexPath.row] {
        case .deletable(let viewModel):
            let cell = collectionView.dequeueCell(DeletableTagViewCell.self, indexPath: indexPath)
            cell.load(viewModel: viewModel)
            cell.didTapDelete
                .map { _ in viewModel.uuid }
                .bind(to: deleteItemSubject)
                .disposed(by: cell.disposeBag)
            return cell
        }
    }
}
