//
//  UIViewExtension.swift
//  Core
//
//  Created by Mariusz Sut on 22/09/2021.
//

import UIKit

public extension UIView {
    static func container(sut: UIView,
                          mode: UIUserInterfaceStyle = .light,
                          size: CGSize = .zero,
                          insets: UIEdgeInsets = .init(all: 8),
                          backgroundColor: UIColor) -> UIView {
        let view = UIView()
        view.backgroundColor = backgroundColor
        view.addSubview(sut)
        view.translatesAutoresizingMaskIntoConstraints = false
        sut.translatesAutoresizingMaskIntoConstraints = false
        sut.topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top).isActive = true
        sut.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: insets.left).isActive = true
        sut.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -insets.right).isActive = true
        sut.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -insets.bottom).isActive = true
        if size.width > 0 {
            sut.widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        if size.height > 0 {
            sut.heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
        view.layoutSubviews()
        view.overrideUserInterfaceStyle = mode
        return view
    }

    static func cellContainer(sut: UITableViewCell,
                              mode: UIUserInterfaceStyle = .light,
                              backgroundColor: UIColor) -> UIView {
        container(sut: sut.contentView,
                  mode: mode,
                  size: CGSize(width: 376, height: 0),
                  insets: .zero,
                  backgroundColor: backgroundColor)
    }

    static func cellContainer(sut: UICollectionViewCell,
                              size: CGSize = CGSize(width: 376, height: 0),
                              mode: UIUserInterfaceStyle = .light,
                              insets: UIEdgeInsets = .zero,
                              backgroundColor: UIColor) -> UIView {
        container(sut: sut.contentView,
                  mode: mode,
                  size: size,
                  insets: insets,
                  backgroundColor: backgroundColor)
    }
}
