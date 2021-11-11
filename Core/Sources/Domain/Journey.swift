//
//  Journey.swift
//  Core
//
//  Created by Mariusz Sut on 25/09/2021.
//

import Foundation

public struct Journey {
    public let uuid: String
    public let name: String
    public let startDate: Date
    public let totalCost: Double
    public let currency: String
    public let participants: [Participant]
}
