//
//  TabBarItem.swift
//  CoinPulse-iOS
//
//  Created by Maksim Botalov on 07.10.2024.
//

import UIKit

struct TabBarItem: TabBarItemProtocol {
    let navigationBarTitle: String
    let tabBarTitle: String
    let tabBarImage: UIImage?
    let rootViewController: UIViewController
}
