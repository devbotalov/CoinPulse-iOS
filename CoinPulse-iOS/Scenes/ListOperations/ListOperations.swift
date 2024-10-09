//
//  ListOperations.swift
//  CoinPulse-iOS
//
//  Created by Maksim Botalov on 07.10.2024.
//

import Foundation

struct ListOperations: ModuleProtocol {
    typealias Configurator = ListOperationsConfigurator
    
    typealias DataStore = ListOperationsDataStore
    
    typealias DisplayLogic = BaseViewController<Router> & ListOperationsDisplayLogic & CollectionViewContaining
    typealias PresentationLogic = ListOperationsPresentationLogic
    typealias BusinessLogic = ListOperationsBusinessLogic & DataStore
    typealias RoutingLogic = ListOperationsRoutingLogic & ListOperationsDataPassing & NSObject
    
    typealias ViewController = ListOperationsViewController
    typealias Presenter = ListOperationsPresenter
    typealias Interactor = ListOperationsInteractor
    typealias Router = ListOperationsRouter
}

protocol ListOperationsDataStore {}

protocol ListOperationsDataPassing {}

protocol ListOperationsDisplayLogic {}

protocol ListOperationsPresentationLogic {}

protocol ListOperationsBusinessLogic {}

protocol ListOperationsRoutingLogic {}

extension ListOperations {
    
    enum Sections: Hashable {
        case calendar
        case operations
        case categories
        case unknown
    }
}
