//
//  AllCategories.swift
//  CoinPulse-iOS
//
//  Created by Maksim Botalov on 15.10.2024.
//

import Foundation

struct AllCategories: ModuleProtocol {
    typealias Configurator = AllCategoriesConfigurator
    
    typealias DataStore = AllCategoriesDataStore
    
    typealias DisplayLogic = BaseViewController<Router> & AllCategoriesDisplayLogic
    typealias PresentationLogic = AllCategoriesPresentationLogic
    typealias BusinessLogic = AllCategoriesBusinessLogic & DataStore
    typealias RoutingLogic = AllCategoriesRoutingLogic & AllCategoriesDataPassing & NSObject
    
    typealias ViewController = AllCategoriesViewController
    typealias Presenter = AllCategoriesPresenter
    typealias Interactor = AllCategoriesInteractor
    typealias Router = AllCategoriesRouter
}

protocol AllCategoriesDataStore {
    var expenseCategories: [CategoryEntity] { get }
    var incomeCategories: [CategoryEntity] { get }
}

protocol AllCategoriesDataPassing {}

protocol AllCategoriesDisplayLogic {
    func displayFetchedCategories(viewModel: AllCategories.FetchCategories.ViewModel)
}

protocol AllCategoriesPresentationLogic {
    func presentFetchedCategories(response: AllCategories.FetchCategories.Response)
}

protocol AllCategoriesBusinessLogic {
    func fetchCategories(request: AllCategories.FetchCategories.Request)
}

protocol AllCategoriesRoutingLogic {}

extension AllCategories {
    enum Sections: Hashable {
        case expense
        case income
        case unknown
    }
}

extension AllCategories {
    enum FetchCategories {
        struct Request: CoreDataRequestProtocol {
            typealias Response = [CategoryEntity]
        }
        
        struct Response {
            let expenseCategories: [CategoryEntity]?
            let incomeCategories: [CategoryEntity]?
        }
        
        struct ViewModel {
            let expenseCategories: [CategoryEntity]?
            let incomeCategories: [CategoryEntity]?
        }
    }
}
