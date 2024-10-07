//
//  TabBarItemProtocol.swift
//  CoinPulse-iOS
//
//  Created by Maksim Botalov on 07.10.2024.
//

import UIKit

protocol TabBarItemProtocol {
    var navigationBarTitle: String { get }
    var tabBarTitle: String { get }
    var tabBarImage: UIImage? { get }
    var rootViewController: UIViewController { get }
}
