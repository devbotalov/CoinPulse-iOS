//
//  UIColor+ToHex.swift
//  CoinPulse-iOS
//
//  Created by Maksim Botalov on 09.10.2024.
//

import UIKit

extension UIColor {
    var hexString: String {
        guard let components = self.cgColor.components else { return "#FFFFFF" }
        
        let r = components[0]
        let g = components.count > 1 ? components[1] : r
        let b = components.count > 2 ? components[2] : r

        let red = Int(r * 255.0)
        let green = Int(g * 255.0)
        let blue = Int(b * 255.0)

        return String(format: "#%02X%02X%02X", red, green, blue)
    }
}
