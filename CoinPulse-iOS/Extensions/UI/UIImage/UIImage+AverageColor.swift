//
//  UIImage+AverageColor.swift
//  CoinPulse-iOS
//
//  Created by Maksim Botalov on 09.10.2024.
//

import UIKit

extension UIImage {
    func averageColor() -> UIColor? {
        guard let cgImage = self.cgImage else { return nil }

        let width = cgImage.width
        let height = cgImage.height
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        
        let context = CGContext(data: nil, width: width, height: height, bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)
        
        context?.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
        
        guard let pixelData = context?.data else { return nil }
        
        let pixelCount = width * height
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        
        for x in 0..<width {
            for y in 0..<height {
                let pixelIndex = ((width * y) + x) * 4
                r += CGFloat(pixelData.load(fromByteOffset: pixelIndex, as: UInt8.self)) / 255.0
                g += CGFloat(pixelData.load(fromByteOffset: pixelIndex + 1, as: UInt8.self)) / 255.0
                b += CGFloat(pixelData.load(fromByteOffset: pixelIndex + 2, as: UInt8.self)) / 255.0
            }
        }
        
        let averageR = r / CGFloat(pixelCount)
        let averageG = g / CGFloat(pixelCount)
        let averageB = b / CGFloat(pixelCount)

        return UIColor(red: averageR, green: averageG, blue: averageB, alpha: 1.0)
    }
}
