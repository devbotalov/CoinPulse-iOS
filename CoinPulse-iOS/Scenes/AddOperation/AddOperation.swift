//
//  AddOperation.swift
//  CoinPulse-iOS
//
//  Created by Maksim Botalov on 07.10.2024.
//

import Foundation

struct AddOperation: ModuleProtocol {
    typealias Configurator = AddOperationConfigurator
    
    typealias DataStore = AddOperationDataStore
    
    typealias DisplayLogic = BaseViewController<Router> & AddOperationDisplayLogic
    typealias PresentationLogic = AddOperationPresentationLogic
    typealias BusinessLogic = AddOperationBusinessLogic & DataStore
    typealias RoutingLogic = AddOperationRoutingLogic & AddOperationDataPassing & NSObject
    
    typealias ViewController = AddOperationViewController
    typealias Presenter = AddOperationPresenter
    typealias Interactor = AddOperationInteractor
    typealias Router = AddOperationRouter
}

protocol AddOperationDataStore {}

protocol AddOperationDataPassing {}

protocol AddOperationDisplayLogic {}

protocol AddOperationPresentationLogic {}

protocol AddOperationBusinessLogic {}

protocol AddOperationRoutingLogic {}
