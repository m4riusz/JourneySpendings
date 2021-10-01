//
//  EmptyViewCell.swift
//  Core
//
//  Created by Mariusz Sut on 01/10/2021.
//

import UIKit
import SnapKit

final public class EmptyViewCell: BaseTableViewCell {
    private lazy var titleLabel = UILabel()
    private lazy var descriptionLabel = UILabel()
    private lazy var button = Button()

    public override func comminInit() {
        titleLabel.numberOfLines = 0
        descriptionLabel.numberOfLines = 0
        button.style = .tertiary
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(button)

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Spacings.normal)
            make.left.equalToSuperview().offset(Spacings.normal)
            make.right.equalToSuperview().offset(-Spacings.normal)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Spacings.normal)
            make.left.equalToSuperview().offset(Spacings.normal)
            make.right.equalToSuperview().offset(-Spacings.normal)
        }

        button.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(Spacings.normal)
            make.left.equalToSuperview().offset(Spacings.normal)
            make.right.equalToSuperview().offset(-Spacings.normal)
            make.bottom.equalToSuperview().offset(-Spacings.normal)
        }
    }
}

extension EmptyViewCell: Loadable {
    public func load(viewModel: EmptyViewCellViewModel) {
        titleLabel.attributedText = viewModel.title.styled(.title2)
        descriptionLabel.attributedText = viewModel.description.styled(.body)
        button.text = viewModel.buttonText
    }
}
