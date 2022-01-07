//
//  SelectableTagViewCell.swift
//  Core
//
//  Created by Sut, Mariusz, (mBank/DBI) on 18/11/2021.
//

import UIKit
import RxSwift
import RxCocoa

final class SelectableTagViewCell: BaseCollectionViewCell, Reusable {
    private typealias Colors = Assets.Colors.Core.Action
    private struct Constants {
        static let borderWidth: CGFloat = 1.5
    }
    private lazy var textLabel = UILabel()
    private lazy var tapGesture = UITapGestureRecognizer()
    var didTap: ControlEvent<UITapGestureRecognizer> {
        tapGesture.rx.event
    }

    override func commonInit() {
        contentView.addSubview(textLabel)
        contentView.layer.borderWidth = Constants.borderWidth
        contentView.addGestureRecognizer(tapGesture)
        textLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Spacings.small)
            make.left.equalToSuperview().offset(Spacings.small)
            make.right.equalToSuperview().offset(-Spacings.small)
            make.bottom.equalToSuperview().offset(-Spacings.small)
        }
    }
}

// MARK: - DeletableTagViewCell
extension SelectableTagViewCell: Loadable {
    func load(viewModel: SelectableTagViewCellViewModel) {
        viewModel.selected ? setSelectedView(text: viewModel.text) : setUnselectedView(text: viewModel.text)
    }

    private func setSelectedView(text: String) {
        contentView.layer.borderColor = Colors.primary.cgColor
        contentView.backgroundColor = Colors.primary
        textLabel.attributedText = text.styled(.callout, attributes: [.color(Colors.primaryText)])
    }

    private func setUnselectedView(text: String) {
        contentView.layer.borderColor = Colors.primary.cgColor
        contentView.backgroundColor = .clear
        textLabel.attributedText = text.styled(.callout, attributes: [.color(Colors.primary)])
    }
}
