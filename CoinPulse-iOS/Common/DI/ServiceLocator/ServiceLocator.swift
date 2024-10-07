//
//  ServiceLocator.swift
//  CoinPulse-iOS
//
//  Created by Maksim Botalov on 06.10.2024.
//

import Foundation

final class ServiceLocator: ServiceLocatorProtocol {
    private var services: [String: Any] = [:]
    
    func register<T>(service: T, completion: ((T) -> Void)? = nil) {
        let key = String(describing: T.self)
        services[key] = service
        
        completion?(service)
    }
    
    func resolve<T>() -> T? {
        let key = String(describing: T.self)
        return services[key] as? T
    }
}
