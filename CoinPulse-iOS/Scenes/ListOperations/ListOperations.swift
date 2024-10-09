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

protocol ListOperationsDataStore {
    var operations: [OperationEntity] { get }
    var categories: [CategoryEntity] { get }
}

protocol ListOperationsDataPassing {}

protocol ListOperationsDisplayLogic {
    func displayFetchedData(viewModel: ListOperations.FetchData.ViewModel)
}

protocol ListOperationsPresentationLogic {
    func presentFetchedData(response: ListOperations.FetchData.Response)
}

protocol ListOperationsBusinessLogic {
    func fetchData(request: ListOperations.FetchData.Request)
}

protocol ListOperationsRoutingLogic {}

extension ListOperations {
    
    enum Sections: Hashable {
        case calendar
        case operations
        case categories
        case unknown
    }
}

extension ListOperations {
    enum FetchData {
        struct Request: CoreDataRequestProtocol {
            typealias Response = ([OperationEntity], [CategoryEntity])
            
            let operationsPredicate: NSPredicate?
            let categoriesPredicate: NSPredicate?
        }
        
        struct Response {
            let operations: [OperationEntity]
            let categories: [CategoryEntity]
        }
        
        struct ViewModel {
            let operations: [OperationEntity]
            let categories: [CategoryEntity]
        }
    }
}
