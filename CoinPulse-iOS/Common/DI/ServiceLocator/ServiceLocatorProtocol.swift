//
//  ServiceLocatorProtocol.swift
//  CoinPulse-iOS
//
//  Created by Maksim Botalov on 06.10.2024.
//

import Foundation

protocol ServiceLocatorProtocol {
    func register<T>(service: T, completion: ((T) -> Void)?)
    func resolve<T>() -> T?
}

extension ServiceLocatorProtocol {
    func register<T>(service: T, completion: ((T) -> Void)? = nil) {}
}
