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

protocol AllCategoriesDataStore {}

protocol AllCategoriesDataPassing {}

protocol AllCategoriesDisplayLogic {}

protocol AllCategoriesPresentationLogic {}

protocol AllCategoriesBusinessLogic {}

protocol AllCategoriesRoutingLogic {}
