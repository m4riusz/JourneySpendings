//
//  DeletableTagViewCell.swift
//  Core
//
//  Created by Mariusz Sut on 26/10/2021.
//

import UIKit
import RxSwift
import RxCocoa

final class DeletableTagViewCell: BaseCollectionViewCell, Reusable {
    private typealias Colors = Assets.Colors.Core.Action
    private struct Constants {
        static let borderWidth: CGFloat = 1.5
    }
    private lazy var textLabel = UILabel()
    private lazy var deleteButton = UIButton()

    var didTapDelete: ControlEvent<Void> {
        deleteButton.rx.tap
    }

    override func commonInit() {
        contentView.addSubview(textLabel)
        contentView.addSubview(deleteButton)
        contentView.layer.borderWidth = Constants.borderWidth
        deleteButton.setImage(Assets.Images.Core.delete, for: .normal)
        textLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Spacings.small)
            make.left.equalToSuperview().offset(Spacings.normal)
            make.bottom.equalToSuperview().offset(-Spacings.small)
        }
        deleteButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Spacings.small)
            make.left.equalTo(textLabel.snp.right).offset(Spacings.small)
            make.right.equalToSuperview().offset(-Spacings.normal)
            make.bottom.equalToSuperview().offset(-Spacings.small)
            make.width.equalTo(deleteButton.snp.height)
        }
        textLabel.setContentHuggingPriority(.required, for: .vertical)
        deleteButton.setContentHuggingPriority(.required, for: .horizontal)
    }
}

// MARK: - DeletableTagViewCell
extension DeletableTagViewCell: Loadable {
    func load(viewModel: DeletableTagViewCellViewModel) {
        viewModel.disabled ? setDisabledView(text: viewModel.text) : setEnabledView(text: viewModel.text)
    }

    private func setEnabledView(text: String) {
        contentView.layer.borderColor = Colors.primary.cgColor
        deleteButton.isUserInteractionEnabled = true
        deleteButton.tintColor = Colors.primary
        textLabel.attributedText = text.styled(.callout, attributes: [.color(Colors.primary)])
    }

    private func setDisabledView(text: String) {
        contentView.layer.borderColor = Colors.disabled.cgColor
        deleteButton.isUserInteractionEnabled = false
        deleteButton.tintColor = Colors.disabled
        textLabel.attributedText = text.styled(.callout, attributes: [.color(Colors.disabled)])
    }
}
