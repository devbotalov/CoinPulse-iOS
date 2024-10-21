//
//  DynamicHeightViewControllerProtocol.swift
//  CoinPulse-iOS
//
//  Created by Maksim Botalov on 16.10.2024.
//

import UIKit

protocol DynamicHeightViewControllerProtocol {}

extension DynamicHeightViewControllerProtocol where Self: UIViewController {
    
    func calculatePreferredSize() -> CGSize {
        let fittingSize = CGSize(width: UIScreen.main.bounds.width, height: UIView.layoutFittingCompressedSize.height)
        
        let targetHeight = view.systemLayoutSizeFitting(
            fittingSize,
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .defaultLow
        ).height
        
        let screenBounds = UIScreen.main.bounds
        let size = CGSize(width: screenBounds.width, height: targetHeight)
        
        return size
    }
}
