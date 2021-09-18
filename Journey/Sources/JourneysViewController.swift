//
//  JourneysViewController.swift
//  Journey
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
        label.attributedText = Assets.Strings.Journey.HelloWorld.styled(.title1)
        label.sizeToFit()
        let image = UIImageView(image: Assets.Images.Journey.search)
        image.frame = CGRect(x: 50, y: 150, width: 50, height: 50)
        view.addSubview(image)
        view.addSubview(label)
        view.backgroundColor = Assets.Colors.Core.Background.primary
    }
}
