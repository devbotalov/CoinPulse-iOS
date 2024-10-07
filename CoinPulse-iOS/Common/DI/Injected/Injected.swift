//
//  Injected.swift
//  CoinPulse-iOS
//
//  Created by Maksim Botalov on 07.10.2024.
//

import Foundation

@propertyWrapper
struct Injected<Service> {
    private var service: Service?
    private var locator: ServiceLocatorProtocol = ServiceLocator.shared
    
    init() {}
    
    var wrappedValue: Service {
        mutating get {
            if service == nil { service = locator.resolve() }
            return service!
        }
        
        mutating set {
            service = newValue
        }
    }
}
