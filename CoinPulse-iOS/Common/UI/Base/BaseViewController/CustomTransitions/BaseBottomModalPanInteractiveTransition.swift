//
//  BaseBottomModalPanInteractiveTransition.swift
//  CoinPulse-iOS
//
//  Created by Maksim Botalov on 16.10.2024.
//

import UIKit

final class BaseBottomModalPanInteractiveTransition: UIPercentDrivenInteractiveTransition {
    
    var interactionInProgress: Bool = false
    private var shouldCompleteTransition: Bool = false
    private var isSwipeable: Bool = true
    unowned var viewController: UIViewController!
    private lazy var panGestureRecognizer: UIPanGestureRecognizer = .init(target: self, action: #selector(handlePan(_:)))

    init(viewController: UIViewController, isSwipeable: Bool = true) {
        super.init()
        self.viewController = viewController
        self.isSwipeable = isSwipeable
        panGestureRecognizer.delegate = self
        self.viewController.view.addGestureRecognizer(panGestureRecognizer)
    }
    
    @objc func handlePan(_ sender: UIPanGestureRecognizer) {
        guard let view = sender.view, isSwipeable else { return }
        
        let translation = sender.translation(in: view).y
        let velocity = sender.velocity(in: view).y
        let progress = CGFloat(translation / view.frame.height)
        
        switch sender.state {
        case .began:
            interactionInProgress = true
            viewController.dismiss(animated: true, completion: nil)
            
        case .changed:
            shouldCompleteTransition = progress > 0 && velocity > 0
            update(progress)
            
        case .cancelled:
            interactionInProgress = false
            cancel()
            
        case .ended:
            interactionInProgress = false
            shouldCompleteTransition ? finish() : cancel()
            
        default: return
        }
    }
}

extension BaseBottomModalPanInteractiveTransition: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        otherGestureRecognizer is UIPanGestureRecognizer
    }
}
