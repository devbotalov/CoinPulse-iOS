//
//  Localizable.swift
//  CoinPulse-iOS
//
//  Created by Maksim Botalov on 07.10.2024.
//

import Foundation

enum Localizable {
    enum TabBar {
        static let localizable: String = "BaseTabBarLocalizable"
        
        enum Add {
            static let tabBar: String.LocalizationValue = "add"
            static let navigationBar: String.LocalizationValue = "addNewOperation"
        }
        
        enum List {
            static let tabBar: String.LocalizationValue = "list"
            static let navigationBar: String.LocalizationValue = "listOperations"
        }
        
        enum Profile {
            static let tabBar: String.LocalizationValue = "profile"
            static let navigationBar: String.LocalizationValue = "profile"
        }
    }
}
