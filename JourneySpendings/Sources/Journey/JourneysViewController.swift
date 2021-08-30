//
//  JourneysViewController.swift
//  JourneySpendings
//
//  Created by Mariusz Sut on 08/08/2021.
//

import UIKit
import Core

final class JourneysViewController: UIViewController {
    
    var viewModel: JourneysViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let label = UILabel(frame: CGRect(x: 50, y: 100, width: 100, height: 24))
        label.text = Assets.Strings.Journey.Hello

        view.addSubview(label)
        view.backgroundColor = .systemGreen
    }
}
