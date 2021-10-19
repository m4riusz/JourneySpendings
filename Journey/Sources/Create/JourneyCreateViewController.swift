//
//  JourneyCreateViewController.swift
//  Journey
//
//  Created by Mariusz Sut on 19/10/2021.
//

import UIKit
import RxSwift

final class JourneyCreateViewController: UIViewController {
    private lazy var disposeBag = DisposeBag()
    private lazy var backButton = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
    var viewModel: JourneyCreateViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = backButton
        navigationItem.backBarButtonItem?.rx.tap
            .subscribe(onNext: { _ in
                print("pressed")
            })
            .disposed(by: disposeBag)
    }
}
