//
//  BaseBottomModalViewController.swift
//  CoinPulse-iOS
//
//  Created by Maksim Botalov on 16.10.2024.
//

import UIKit

class BaseBottomModalViewController<Router>: BaseViewController<Router>, BaseBottomModalPresented {
    
    final var interactiveTransition: BaseBottomModalPanInteractiveTransition?
    var isSwipeable: Bool { true }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        preferredContentSize = UIScreen.main.bounds.size
    }
    
    override func setupViewController() {
        super.setupViewController()
        interactiveTransition = .init(viewController: self, isSwipeable: isSwipeable)
    }
}
