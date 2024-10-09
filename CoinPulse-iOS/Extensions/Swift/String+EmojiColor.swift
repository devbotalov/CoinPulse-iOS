//
//  String+EmojiColor.swift
//  CoinPulse-iOS
//
//  Created by Maksim Botalov on 09.10.2024.
//

import UIKit

extension String {
    func emojiColor() -> UIColor? {
        let label = UILabel()
        label.text = self
        label.font = UIFont.systemFont(ofSize: 100)
        label.sizeToFit()

        let renderer = UIGraphicsImageRenderer(size: label.bounds.size)
        
        let emojiImage = renderer.image { _ in
            label.drawText(in: label.bounds)
        }

        return emojiImage.averageColor()
    }
}
