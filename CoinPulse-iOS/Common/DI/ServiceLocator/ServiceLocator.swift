//
//  ServiceLocator.swift
//  CoinPulse-iOS
//
//  Created by Maksim Botalov on 06.10.2024.
//

import Foundation

final class ServiceLocator: ServiceLocatorProtocol {
    
    static let shared: ServiceLocatorProtocol = ServiceLocator()
    
    private var services: [String: Any] = [:]
    
    private init() {}
    
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
