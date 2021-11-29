//
//  TableViewSection.swift
//  Core
//
//  Created by Sut, Mariusz, (mBank/DBI) on 29/11/2021.
//

import UIKit

final public class TableViewSection: UITableViewHeaderFooterView, Reusable {

    private lazy var stackView = UIStackView()
    private lazy var titleLabel = UILabel()
    private lazy var actionButton = Button()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not supported")
    }
    
    private func commonInit() {
        stackView.axis = .horizontal
        stackView.spacing = Spacings.normal
        actionButton.style = .tertiary
        actionButton.setContentCompressionResistancePriority(.required, for: .horizontal)
        actionButton.setContentHuggingPriority(.required, for: .horizontal)
        addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(actionButton)
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Spacings.small)
            make.left.equalToSuperview().offset(Spacings.normal)
            make.right.equalToSuperview().offset(-Spacings.normal)
            make.bottom.equalToSuperview().offset(-Spacings.small)
        }
    }
}

// MARK: - Loadable
extension TableViewSection: Loadable {
    public func load(viewModel: TableViewSectionViewModel) {
        titleLabel.attributedText = viewModel.title.styled(.subhead, attributes: [.color(Assets.Colors.Core.Label.secondary)])
        actionButton.text = viewModel.button ?? ""
        actionButton.isHidden = viewModel.button.isNilOrEmpty
    }
}
