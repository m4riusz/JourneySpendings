//
//  TextFieldCell.swift
//  Journey
//
//  Created by Mariusz Sut on 22/10/2021.
//

import Foundation
import Core

final class TextFieldCell: BaseTableViewCell {
    private lazy var textField = TextField()

    override func comminInit() {
        contentView.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Spacings.normal)
            make.left.equalToSuperview().offset(Spacings.normal)
            make.right.equalToSuperview().offset(-Spacings.normal)
            make.bottom.equalToSuperview().offset(-Spacings.normal)
        }
    }
}

extension TextFieldCell: Loadable {
    func load(viewModel: TextFieldCellViewModel) {
        textField.titleText = viewModel.title
        textField.placeholder = viewModel.placeholder
        textField.helperText = viewModel.helper
        textField.errorText = viewModel.error
    }
}
