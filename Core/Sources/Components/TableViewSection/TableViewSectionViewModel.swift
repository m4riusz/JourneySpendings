//
//  TableViewSectionViewModel.swift
//  Core
//
//  Created by Sut, Mariusz, (mBank/DBI) on 29/11/2021.
//

import Foundation

public struct TableViewSectionViewModel {
    let title: String
    let button: String?
    
    init(title: String, button: String? = nil) {
        self.title = title
        self.button = button
    }
}
