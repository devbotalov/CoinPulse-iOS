//
//  AddCategoryConfigurator.swift
//  CoinPulse-iOS
//
//  Created by Maksim Botalov on 18.10.2024.
//

import Foundation

struct AddCategoryConfigurator: ConfiguratorProtocol {
    static func configureViewController(for locator: ServiceLocatorProtocol) {
        locator.register(service: AddCategory.ViewController()) { viewController in
            let interactor = AddCategoryInteractor()
            let presenter = AddCategoryPresenter()
            let router = AddCategoryRouter()
            
            viewController.interactor = interactor
            viewController.router = router
            
            interactor.presenter = presenter
            
            presenter.viewController = viewController
            
            router.viewController = viewController
            router.dataStore = interactor
        }
    }
    
    static func configureInteractor(for locator: ServiceLocatorProtocol) {
        locator.register(service: AddCategory.Interactor())
    }
    
    static func configurePresenter(for locator: ServiceLocatorProtocol) {
        locator.register(service: AddCategory.Presenter())
    }
    
    static func configureRouter(for locator: ServiceLocatorProtocol) {
        locator.register(service: AddCategory.Router())
    }
}
