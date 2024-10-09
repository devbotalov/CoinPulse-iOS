//
//  ListOperationsCalendarDayCellProtocol.swift
//  CoinPulse-iOS
//
//  Created by Maksim Botalov on 09.10.2024.
//

import Foundation

protocol ListOperationsCalendarDayCellProtocol {
    func configureCell(shortDay shortDay: String, dayMonth: String, isCurrent: Bool, isSelected: Bool)
}
