//
//  ListOperationsPresenter.swift
//  CoinPulse-iOS
//
//  Created by Maksim Botalov on 07.10.2024.
//

import Foundation

final class ListOperationsPresenter: ListOperations.PresentationLogic {
    var viewController: ListOperations.DisplayLogic?
    
    func presentFetchedInitialData(response: ListOperations.FetchInitialWeekData.Response) {
        let viewModel = ListOperations.FetchInitialWeekData.ViewModel(
            calendarDays: response.calendarDays,
            operations: response.operations,
            categories: response.categories,
            weeklyAmount: response.weeklyAmount
        )
        
        viewController?.displayFetchedInitialData(viewModel: viewModel)
    }
    
    func presentFetchedWeekOfCalendar(response: ListOperations.FetchWeekOfCalendar.Response) {
        let viewModel = ListOperations.FetchWeekOfCalendar.ViewModel(
            calendarDays: response.calendarDays
        )
        
        viewController?.displayFetchedWeekOfCalendar(viewModel: viewModel)
    }
    
    func presentFetchedOperationsByWeek(response: ListOperations.FetchOperationsByWeek.Response) {
        let viewModel = ListOperations.FetchOperationsByWeek.ViewModel(
            operations: response.operations
        )
        
        viewController?.displayFetchedOperationsByWeek(viewModel: viewModel)
    }
}
