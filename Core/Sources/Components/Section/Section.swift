//
//  Section.swift
//  Core
//
//  Created by Sut, Mariusz, (mBank/DBI) on 29/11/2021.
//

import UIKit
import RxDataSources

public protocol SectionProtocol {
    var title: String { get }
    var button: String? { get }
}

final public class Section: UICollectionReusableView, Reusable {
    private lazy var stackView = UIStackView()
    private lazy var titleLabel = UILabel()
    private lazy var actionButton = Button()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(frame: .zero)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = Assets.Colors.Core.Background.primary
        stackView.axis = .horizontal
        stackView.spacing = Spacings.normal
        actionButton.style = .tertiary
        actionButton.setContentCompressionResistancePriority(.required, for: .horizontal)
        actionButton.setContentHuggingPriority(.required, for: .horizontal)
        addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(actionButton)
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(Spacings.normal)
            make.right.equalToSuperview().offset(-Spacings.normal)
            make.bottom.equalToSuperview()
            make.height.equalTo(0).priority(.medium)
        }
    }
}

// MARK: - Loadable
extension Section: Loadable {
    public func load(viewModel: SectionProtocol) {
        titleLabel.attributedText = viewModel.title.styled(.subhead, attributes: [.color(Assets.Colors.Core.Label.secondary)])
        actionButton.text = viewModel.button ?? ""
        actionButton.isHidden = viewModel.button.isNilOrEmpty
        titleLabel.isHidden = viewModel.title.isEmpty
    }
}
