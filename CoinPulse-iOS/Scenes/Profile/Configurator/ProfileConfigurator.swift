//
//  ProfileConfigurator.swift
//  CoinPulse-iOS
//
//  Created by Maksim Botalov on 07.10.2024.
//

import Foundation

struct ProfileConfigurator: ConfiguratorProtocol {
    static func configureViewController(for locator: ServiceLocatorProtocol) {
        locator.register(service: Profile.ViewController()) { viewController in
            let interactor = ProfileInteractor()
            let presenter = ProfilePresenter()
            let router = ProfileRouter()
            
            viewController.interactor = interactor
            viewController.router = router
            
            interactor.presenter = presenter
            
            presenter.viewController = viewController
            
            router.viewController = viewController
            router.dataStore = interactor
        }
    }
    
    static func configureInteractor(for locator: ServiceLocatorProtocol) {
        locator.register(service: Profile.Interactor())
    }
    
    static func configurePresenter(for locator: ServiceLocatorProtocol) {
        locator.register(service: Profile.Presenter())
    }
    
    static func configureRouter(for locator: ServiceLocatorProtocol) {
        locator.register(service: Profile.Router())
    }
}
