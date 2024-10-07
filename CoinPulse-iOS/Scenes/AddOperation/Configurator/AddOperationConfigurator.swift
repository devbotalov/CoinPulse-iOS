//
//  AddOperationConfigurator.swift
//  CoinPulse-iOS
//
//  Created by Maksim Botalov on 07.10.2024.
//

import UIKit

struct AddOperationConfigurator: ConfiguratorProtocol {
    static func configureViewController(for locator: ServiceLocatorProtocol) {
        if let viewController = locator.resolve() as AddOperation.ViewController? {
            let interactor = AddOperationInteractor()
            let presenter = AddOperationPresenter()
            let router = AddOperationRouter()
            
            viewController.interactor = interactor
            viewController.router = router
            
            interactor.presenter = presenter
            
            presenter.viewController = viewController
            
            router.viewController = viewController
            router.dataStore = interactor
        }
    }
    
    static func configureInteractor(for locator: ServiceLocatorProtocol) {
        locator.register(service: AddOperation.Interactor())
    }
    
    static func configurePresenter(for locator: ServiceLocatorProtocol) {
        locator.register(service: AddOperation.Presenter())
    }

    static func configureRouter(for locator: ServiceLocatorProtocol) {
        locator.register(service: AddOperation.Router())
    }
}
