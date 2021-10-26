//
//  TagViewCell.swift
//  Core
//
//  Created by Mariusz Sut on 26/10/2021.
//

import UIKit

final class TagViewCell: BaseCollectionViewCell {

    private lazy var textLabel = UILabel()

    override func commonInit() {
        contentView.addSubview(textLabel)
        textLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Spacings.small)
            make.left.equalToSuperview().offset(Spacings.small)
            make.right.equalToSuperview().offset(-Spacings.small)
            make.bottom.equalToSuperview().offset(-Spacings.small)
        }
    }
}

extension TagViewCell: Loadable {
    func load(viewModel: TagViewCellViewModel) {
        textLabel.attributedText = viewModel.text.styled(.subhead)
    }
}
