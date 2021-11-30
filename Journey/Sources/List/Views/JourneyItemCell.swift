//
//  JourneyItemCell.swift
//  Journey
//
//  Created by Mariusz Sut on 25/09/2021.
//

import UIKit
import Core

final class JourneyItemCell: BaseCollectionViewCell, Reusable {
    private lazy var titleLabel = UILabel()
    private lazy var startDateLabel = UILabel()
    private lazy var totalCostLabel = UILabel()

    override func commonInit() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(startDateLabel)
        contentView.addSubview(totalCostLabel)

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Spacings.normal)
            make.left.equalToSuperview().offset(Spacings.normal)
        }

        startDateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Spacings.small)
            make.left.equalToSuperview().offset(Spacings.normal)
            make.bottom.equalToSuperview().offset(-Spacings.normal)
        }

        totalCostLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Spacings.normal)
            make.left.equalTo(titleLabel.snp.right).offset(Spacings.normal)
            make.left.equalTo(startDateLabel.snp.right).offset(Spacings.normal)
            make.right.equalToSuperview().offset(-Spacings.normal)
            make.bottom.equalToSuperview().offset(-Spacings.normal)
        }

        totalCostLabel.setContentHuggingPriority(.required, for: .horizontal)
    }
}

extension JourneyItemCell: Loadable {
    func load(viewModel: JourneysItemCellViewModel) {
        titleLabel.attributedText = viewModel.name.styled(.title3)
        startDateLabel.attributedText = viewModel.startDate.styled(.body)
        totalCostLabel.attributedText = viewModel.totalCost.styled(.headline)
    }
}
