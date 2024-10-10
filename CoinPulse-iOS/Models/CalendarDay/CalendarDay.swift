//
//  CalendarDay.swift
//  CoinPulse-iOS
//
//  Created by Maksim Botalov on 10.10.2024.
//

import Foundation

struct CalendarDay: CalendarDayProtocol {
    let id: UUID
    let title: String
    let number: String
    let isCurrent: Bool
    let isSelected: Bool
    
    init(id: UUID = UUID(), title: String, number: String, isCurrent: Bool, isSelected: Bool) {
        self.id = id
        self.title = title
        self.number = number
        self.isCurrent = isCurrent
        self.isSelected = isSelected
    }
    
    func select() -> CalendarDay {
        return CalendarDay(
            id: self.id,
            title: self.title,
            number: self.number,
            isCurrent: self.isCurrent,
            isSelected: !self.isSelected
        )
    }
}
