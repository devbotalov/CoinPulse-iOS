//
//  Double+Currency.swift
//  CoinPulse-iOS
//
//  Created by Maksim Botalov on 14.10.2024.
//

import Foundation

extension Double {
    var toCurrency: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "ru_RU")
        return formatter.string(from: NSNumber(value: self)) ?? ""
    }
}
