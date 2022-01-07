//
//  JourneyExpenseCell.swift
//  Journey
//
//  Created by Sut, Mariusz, (mBank/DBI) on 01/12/2021.
//

import UIKit
import Core

final class JourneyExpenseCell: BaseCollectionViewCell, Reusable {
    private lazy var titleLabel = UILabel()
    private lazy var personsLabel = UILabel()
    private lazy var costLabel = UILabel()

    override func commonInit() {
        super.commonInit()
        titleLabel.numberOfLines = 2
        costLabel.numberOfLines = 1
        contentView.addSubview(titleLabel)
        contentView.addSubview(personsLabel)
        contentView.addSubview(costLabel)

        titleLabel.setContentHuggingPriority(.required, for: .vertical)
        titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        costLabel.setContentHuggingPriority(.required, for: .horizontal)
        costLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Spacings.small)
            make.left.equalToSuperview().offset(Spacings.normal)
        }
        personsLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Spacings.small)
            make.left.equalToSuperview().offset(Spacings.normal)
            make.bottom.equalToSuperview().offset(-Spacings.small)
        }
        costLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Spacings.small)
            make.left.equalTo(titleLabel.snp.right).offset(Spacings.normal)
            make.left.equalTo(personsLabel.snp.right).offset(-Spacings.normal)
            make.right.equalToSuperview().offset(-Spacings.normal)
            make.bottom.equalToSuperview().offset(-Spacings.small)
        }
    }
}

// MARK: - Loadable
extension JourneyExpenseCell: Loadable {
    func load(viewModel: JourneyExpenseCellViewModel) {
        titleLabel.attributedText = viewModel.title.styled(.body, attributes: [.color(Assets.Colors.Core.Label.primary)])
        personsLabel.attributedText = viewModel.persons.styled(.callout)
        costLabel.attributedText = viewModel.cost.styled(.headline)
    }
}
