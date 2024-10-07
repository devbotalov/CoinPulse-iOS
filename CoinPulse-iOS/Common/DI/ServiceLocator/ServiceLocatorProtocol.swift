//
//  ServiceLocatorProtocol.swift
//  CoinPulse-iOS
//
//  Created by Maksim Botalov on 06.10.2024.
//

import Foundation

protocol ServiceLocatorProtocol {
    func register<T>(service: T)
    func resolve<T>() -> T?
}
