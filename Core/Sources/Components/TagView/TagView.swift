//
//  TagView.swift
//  Core
//
//  Created by Mariusz Sut on 26/10/2021.
//

import UIKit

final class TagView: UIView {
    private lazy var collectionView = UICollectionView(frame: .zero)

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(frame: .zero)
        commonInit()
    }

    private func commonInit() {
        
        collectionView.register(TagViewCell.self, forCellWithReuseIdentifier: "TagViewCell") // TODO: create extension for registation cells
        
    }
}
