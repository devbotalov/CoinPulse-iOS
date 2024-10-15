//
//  ListOperationsConfigurator.swift
//  CoinPulse-iOS
//
//  Created by Maksim Botalov on 07.10.2024.
//

import Foundation

struct ListOperationsConfigurator: ConfiguratorProtocol {
    static func configureViewController(for locator: ServiceLocatorProtocol) {
        locator.register(service: ListOperations.ViewController()) { viewController in
            let interactor = ListOperationsInteractor()
            let presenter = ListOperationsPresenter()
            let router = ListOperationsRouter()
            
            viewController.interactor = interactor
            viewController.router = router
            
            interactor.presenter = presenter
            
            presenter.viewController = viewController
            
            router.viewController = viewController
            router.dataStore = interactor
        }
    }
    
    static func configureInteractor(for locator: ServiceLocatorProtocol) {
        locator.register(service: ListOperations.Interactor())
    }
    
    static func configurePresenter(for locator: ServiceLocatorProtocol) {
        locator.register(service: ListOperations.Presenter())
    }
    
    static func configureRouter(for locator: ServiceLocatorProtocol) {
        locator.register(service: ListOperations.Router())
    }
}
