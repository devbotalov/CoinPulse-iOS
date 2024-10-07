//
//  ConfiguratorProtocol.swift
//  CoinPulse-iOS
//
//  Created by Maksim Botalov on 06.10.2024.
//

import Foundation

protocol ConfiguratorProtocol {
    static func registerDependencies(in locator: ServiceLocatorProtocol)
    
    static func configureViewController(for locator: ServiceLocatorProtocol)
    static func configureInteractor(for locator: ServiceLocatorProtocol)
    static func configureWorker(for locator: ServiceLocatorProtocol)
    static func configureRouter(for locator: ServiceLocatorProtocol)
    static func configurePresenter(for locator: ServiceLocatorProtocol)
}

extension ConfiguratorProtocol {
    static func registerDependencies(in locator: ServiceLocatorProtocol) {
        configureViewController(for: locator)
        configureInteractor(for: locator)
        configureWorker(for: locator)
        configureRouter(for: locator)
        configurePresenter(for: locator)
    }
    
    static func configureInteractor(for locator: ServiceLocatorProtocol) {}
    static func configureWorker(for locator: ServiceLocatorProtocol) {}
    static func configureRouter(for locator: ServiceLocatorProtocol) {}
    static func configurePresenter(for locator: ServiceLocatorProtocol) {}
}
