//
//  CellRepresentable.swift
//  Core
//
//  Created by Mariusz Sut on 25/09/2021.
//

import Foundation
import UIKit

public protocol CellConfiguratorProtocol {
    var cellConfigurator: CellRepresentable { get }
}

public protocol CellRepresentable {
    static var reuseId: String { get }
    func configure(cell: UIView)
}

public struct CellConfigurator<CellType: Loadable, DataType>: CellRepresentable where CellType.ViewModel == DataType, CellType: UITableViewCell {
    public static var reuseId: String { return String(describing: CellType.self) }

    public let item: DataType

    public init(item: DataType) {
        self.item = item
    }

    public func configure(cell: UIView) {
        (cell as! CellType).load(viewModel: item)
    }
}
