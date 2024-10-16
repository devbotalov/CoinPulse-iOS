//
//  BaseBottomModalPresented.swift
//  CoinPulse-iOS
//
//  Created by Maksim Botalov on 16.10.2024.
//

import Foundation

protocol BaseBottomModalPresented: AnyObject {
    var interactiveTransition: BaseBottomModalPanInteractiveTransition? { get set }
}
