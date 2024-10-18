//
//  AddCategory.swift
//  CoinPulse-iOS
//
//  Created by Maksim Botalov on 18.10.2024.
//

import Foundation

struct AddCategory: ModuleProtocol {
    typealias Configurator = AddCategoryConfigurator
    
    typealias DataStore = AddCategoryDataStore
    
    typealias DisplayLogic = BaseBottomModalViewController<Router> & AddCategoryDisplayLogic
    typealias PresentationLogic = AddCategoryPresentationLogic
    typealias BusinessLogic = AddCategoryBusinessLogic & DataStore
    typealias RoutingLogic = AddCategoryRoutingLogic & AddCategoryDataPassing & NSObject
    
    typealias ViewController = AddCategoryViewController
    typealias Presenter = AddCategoryPresenter
    typealias Interactor = AddCategoryInteractor
    typealias Router = AddCategoryRouter
}

protocol AddCategoryDataStore {}

protocol AddCategoryDataPassing {}

protocol AddCategoryDisplayLogic {
    // func displayFetchedCategories(viewModel: AllCategories.FetchCategories.ViewModel)
}

protocol AddCategoryPresentationLogic {
    // func presentFetchedCategories(response: AllCategories.FetchCategories.Response)
}

protocol AddCategoryBusinessLogic {
    // func fetchCategories(request: AllCategories.FetchCategories.Request)
}

protocol AddCategoryRoutingLogic {}

extension AddCategory {
    /*
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
     */
}
