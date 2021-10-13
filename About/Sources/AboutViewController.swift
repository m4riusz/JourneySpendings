//
//  AboutViewController.swift
//  About
//
//  Created by Mariusz Sut on 08/08/2021.
//

import UIKit
import Core

final class AboutViewController: UIViewController {
    var viewModel: AboutViewModel!
    private lazy var textfield1 = TextField()
    private lazy var textfield2 = TextField()
    private lazy var textfield3 = TextField()
    private lazy var textfield4 = TextField()

    override func viewDidLoad() {

        view.addSubview(textfield1)
        view.addSubview(textfield2)
        view.addSubview(textfield3)
        view.addSubview(textfield4)

        textfield1.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.left.equalToSuperview().offset(10)
        }

        textfield2.snp.makeConstraints { make in
            make.top.equalTo(textfield1.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
        }
        textfield3.snp.makeConstraints { make in
            make.top.equalTo(textfield2.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
        }
        textfield4.snp.makeConstraints { make in
            make.top.equalTo(textfield3.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
        }

        textfield1.placeholder = "Placeholder textfield1"
        textfield2.placeholder = "Placeholder textfield2"
        textfield3.placeholder = "Placeholder textfield3"
        textfield4.placeholder = "Placeholder textfield4"

        textfield1.text = "textfield1"
        textfield2.text = "textfield2"
        textfield3.text = "textfield3"
        textfield4.text = "textfield4"

        textfield2.titleText = "Title text"

        textfield3.titleText = "Title text"
        textfield3.errorText = "error text"

        textfield4.titleText = "Title text"
        textfield4.errorText = "error text"
        textfield4.helperText = "helper text"

    }
}
