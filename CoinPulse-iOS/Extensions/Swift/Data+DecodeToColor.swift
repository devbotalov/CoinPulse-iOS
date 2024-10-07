//
//  Data+DecodeToColor.swift
//  CoinPulse-iOS
//
//  Created by Maksim Botalov on 07.10.2024.
//

import UIKit

extension Data {
    func decodeToColor() -> UIColor? {
        return try! NSKeyedUnarchiver.unarchivedObject(
            ofClass: UIColor.self,
            from: self
        )
    }
}
