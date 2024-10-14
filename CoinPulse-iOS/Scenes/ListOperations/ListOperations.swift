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
    var operationsPerWeek: [OperationEntity] { get }
    var categoriesPerWeek: [CategoryEntity] { get }
    var operationsPerDay: [OperationEntity] { get }
}

protocol ListOperationsDataPassing {}

protocol ListOperationsDisplayLogic {
    func displayFetchedInitialData(viewModel: ListOperations.FetchInitialWeekData.ViewModel)
    func displayFetchedWeekOfCalendar(viewModel: ListOperations.FetchWeekOfCalendar.ViewModel)
    func displayFetchedOperationsByWeek(viewModel: ListOperations.FetchOperationsByWeek.ViewModel)
}

protocol ListOperationsPresentationLogic {
    func presentFetchedInitialData(response: ListOperations.FetchInitialWeekData.Response)
    func presentFetchedWeekOfCalendar(response: ListOperations.FetchWeekOfCalendar.Response)
    func presentFetchedOperationsByWeek(response: ListOperations.FetchOperationsByWeek.Response)
}

protocol ListOperationsBusinessLogic {
    func fetchInitialDataPerWeek(request: ListOperations.FetchInitialWeekData.Request)
    func fetchWeekOfCalendar(request: ListOperations.FetchWeekOfCalendar.Request)
    func fetchOperationsByDay(request: ListOperations.FetchOperationsByWeek.Request)
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
    enum FetchInitialWeekData {
        struct Request: CoreDataRequestProtocol {
            typealias Response = ([CalendarDay], [OperationEntity], [CategoryEntity])
            
            let weekFromCurrent: Int?
        }
        
        struct Response {
            let calendarDays: [CalendarDay]
            let operations: [OperationEntity]
            let categories: [CategoryEntity]
        }
        
        struct ViewModel {
            let calendarDays: [CalendarDay]
            let operations: [OperationEntity]
            let categories: [CategoryEntity]
        }
    }
    
    enum FetchWeekOfCalendar {
        struct Request: CoreDataRequestProtocol {
            typealias Response = [CalendarDay]
            
            let selectedDay: Int?
            let weekFromCurrent: Int?
        }
        
        struct Response {
            let calendarDays: [CalendarDay]
        }
        
        struct ViewModel {
            let calendarDays: [CalendarDay]
        }
    }
    
    enum FetchOperationsByWeek {
        struct Request: CoreDataRequestProtocol {
            typealias Response = [OperationEntity]
            
            let day: CalendarDay
        }
        
        struct Response {
            let operations: [OperationEntity]
        }
        
        struct ViewModel {
            let operations: [OperationEntity]
        }
    }
}
