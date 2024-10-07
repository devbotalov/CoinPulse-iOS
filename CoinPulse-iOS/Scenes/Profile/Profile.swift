//
//  Profile.swift
//  CoinPulse-iOS
//
//  Created by Maksim Botalov on 07.10.2024.
//

import Foundation

struct Profile: ModuleProtocol {
    typealias Configurator = ProfileConfigurator
    
    typealias DataStore = ProfileDataStore
    
    typealias DisplayLogic = BaseViewController<Router> & ProfileDisplayLogic
    typealias PresentationLogic = ProfilePresentationLogic
    typealias BusinessLogic = ProfileBusinessLogic & DataStore
    typealias RoutingLogic = ProfileRoutingLogic & ProfileDataPassing & NSObject
    
    typealias ViewController = ProfileViewController
    typealias Presenter = ProfilePresenter
    typealias Interactor = ProfileInteractor
    typealias Router = ProfileRouter
}

protocol ProfileDataStore {}

protocol ProfileDataPassing {}

protocol ProfileDisplayLogic {}

protocol ProfilePresentationLogic {}

protocol ProfileBusinessLogic {}

protocol ProfileRoutingLogic {}
