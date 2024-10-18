//
//  AllCategoriesConfigurator.swift
//  CoinPulse-iOS
//
//  Created by Maksim Botalov on 15.10.2024.
//

import Foundation

struct AllCategoriesConfigurator: ConfiguratorProtocol {
    static func configureViewController(for locator: ServiceLocatorProtocol) {
        locator.register(service: AllCategories.ViewController()) { viewController in
            let interactor = AllCategoriesInteractor()
            let presenter = AllCategoriesPresenter()
            let router = AllCategoriesRouter()
            
            viewController.interactor = interactor
            viewController.router = router
            
            interactor.presenter = presenter
            
            presenter.viewController = viewController
            
            router.viewController = viewController
            router.dataStore = interactor
        }
    }
    
    static func configureInteractor(for locator: ServiceLocatorProtocol) {
        locator.register(service: AllCategories.Interactor())
    }
    
    static func configurePresenter(for locator: ServiceLocatorProtocol) {
        locator.register(service: AllCategories.Presenter())
    }
    
    static func configureRouter(for locator: ServiceLocatorProtocol) {
        locator.register(service: AllCategories.Router())
    }
}
