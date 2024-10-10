//
//  CalendarDayProtocol.swift
//  CoinPulse-iOS
//
//  Created by Maksim Botalov on 10.10.2024.
//

import Foundation

protocol CalendarDayProtocol: Hashable, Identifiable {
    var title: String { get }
    var number: String { get }
    var isCurrent: Bool { get }
    var isSelected: Bool { get }
}
