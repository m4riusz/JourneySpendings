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
        view.backgroundColor = Assets.Colors.Core.Background.primary
        let button1 = Button(frame: CGRect(x: 10, y: 100, width: 120, height: 40))
        button1.text = "BUTTON 1"
        button1.style = .primary
        let button1Disabled = Button(frame: CGRect(x: 150, y: 100, width: 120, height: 40))
        button1Disabled.text = "BUTTON 1"
        button1Disabled.style = .primary
        button1Disabled.isEnabled = false
        let button2 = Button(frame: CGRect(x: 10, y: 150, width: 120, height: 40))
        button2.text = "BUTTON 2"
        button2.style = .secondary
        let button2Disabled = Button(frame: CGRect(x: 150, y: 150, width: 120, height: 40))
        button2Disabled.text = "BUTTON 2"
        button2Disabled.style = .secondary
        button2Disabled.isEnabled = false
        let button3 = Button(frame: CGRect(x: 10, y: 200, width: 120, height: 40))
        button3.text = "BUTTON 1"
        button3.style = .tertiary
        let button3Disabled = Button(frame: CGRect(x: 150, y: 200, width: 120, height: 40))
        button3Disabled.text = "BUTTON 3"
        button3Disabled.style = .tertiary
        button3Disabled.isEnabled = false

        view.addSubview(button1)
        view.addSubview(button1Disabled)
        view.addSubview(button2)
        view.addSubview(button2Disabled)
        view.addSubview(button3)
        view.addSubview(button3Disabled)
    }
}
