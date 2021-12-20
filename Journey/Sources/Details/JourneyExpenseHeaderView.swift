//
//  JourneyExpenseHeaderView.swift
//  Journey
//
//  Created by Sut, Mariusz, (mBank/DBI) on 03/12/2021.
//

import Core
import UIKit
import RxCocoa

final class JourneyExpenseHeaderView: UIView {
    private lazy var contentView = UIView()
    private lazy var titleLabel = UILabel()
    private lazy var actionButton = Button()
    
    var title: String = "" {
        didSet { titleLabel.attributedText = title.styled(.subhead) }
    }
    
    var action: String = "" {
        didSet { actionButton.text = action }
    }
    
    var actionTap: ControlEvent<Void> {
        actionButton.rx.tap
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(frame: .zero)
        commonInit()
    }
    
    private func commonInit() {
        actionButton.style = .tertiary
        actionButton.setContentCompressionResistancePriority(.required, for: .horizontal)
        actionButton.setContentHuggingPriority(.required, for: .horizontal)
        contentView.addSubview(titleLabel)
        contentView.addSubview(actionButton)
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        addSubview(contentView)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        actionButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(titleLabel.snp.right).offset(Spacings.normal)
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        contentView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
}
