//
//  ReusableView.swift
//  CoinPulse-iOS
//
//  Created by Maksim Botalov on 07.10.2024.
//

import UIKit

protocol ReusableView: AnyObject {}

extension ReusableView where Self: UIResponder {
    static var reuseID: String { return .init(describing: self) }
}
