//
//  UIView+ShakeAnimation.swift
//  CoinPulse-iOS
//
//  Created by Maksim Botalov on 09.10.2024.
//

import UIKit

import UIKit

extension UIView {
    func shakeAnimation() {
        let shake = CAKeyframeAnimation(keyPath: "transform.translation.y")
        shake.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        shake.values = [0, 4, 8, 4, 0]
        shake.duration = 2
        shake.repeatCount = .infinity
        self.layer.add(shake, forKey: "shake")
    }
}
