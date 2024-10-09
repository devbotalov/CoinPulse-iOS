//
//  UIColor+EncodeToData.swift
//  CoinPulse-iOS
//
//  Created by Maksim Botalov on 07.10.2024.
//

import UIKit

extension UIColor {
    func encode() -> Data {
        return try! NSKeyedArchiver.archivedData(
            withRootObject: self,
            requiringSecureCoding: false
        )
    }
}
