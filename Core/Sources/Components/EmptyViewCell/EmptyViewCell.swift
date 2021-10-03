//
//  EmptyViewCell.swift
//  Core
//
//  Created by Mariusz Sut on 01/10/2021.
//

import UIKit
import SnapKit

final public class EmptyViewCell: BaseTableViewCell {
    private struct Constants {
        static let maxTitleLines = 1
        static let maxDescriptionLines = 3
        static let imageViewHeight: CGFloat = 128
    }
    private lazy var emptyImageView = UIImageView()
    private lazy var titleLabel = UILabel()
    private lazy var descriptionLabel = UILabel()
    private lazy var button = Button()

    public override func comminInit() {
        emptyImageView.contentMode = .scaleAspectFit
        titleLabel.numberOfLines = Constants.maxTitleLines
        descriptionLabel.numberOfLines = Constants.maxDescriptionLines
        button.style = .tertiary
        contentView.addSubview(emptyImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(button)

        emptyImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Spacings.huge)
            make.left.equalToSuperview().offset(Spacings.normal)
            make.right.equalToSuperview().offset(-Spacings.normal)
            make.height.equalTo(Constants.imageViewHeight)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(emptyImageView.snp.bottom).offset(Spacings.huge)
            make.left.equalToSuperview().offset(Spacings.normal)
            make.right.equalToSuperview().offset(-Spacings.normal)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Spacings.normal)
            make.left.equalToSuperview().offset(Spacings.normal)
            make.right.equalToSuperview().offset(-Spacings.normal)
        }

        button.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(Spacings.big)
            make.left.greaterThanOrEqualToSuperview().offset(Spacings.normal)
            make.right.lessThanOrEqualToSuperview().offset(-Spacings.normal)
            make.bottom.equalToSuperview().offset(-Spacings.huge)
            make.centerX.equalToSuperview()
        }
    }
}

extension EmptyViewCell: Loadable {
    public func load(viewModel: EmptyViewCellViewModel) {
        emptyImageView.image = viewModel.image
        emptyImageView.tintColor = Assets.Colors.Core.Label.secondary
        titleLabel.attributedText = viewModel.title.styled(.title2, attributes: [.alignment(.center)])
        descriptionLabel.attributedText = viewModel.description.styled(.body, attributes: [.alignment(.center)])
        button.text = viewModel.buttonText
    }
}
