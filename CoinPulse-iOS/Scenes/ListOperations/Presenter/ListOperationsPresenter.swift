//
//  ListOperationsPresenter.swift
//  CoinPulse-iOS
//
//  Created by Maksim Botalov on 07.10.2024.
//

import Foundation

final class ListOperationsPresenter: ListOperations.PresentationLogic {
    var viewController: ListOperations.DisplayLogic?
    
    func presentFetchedInitialData(response: ListOperations.FetchInitialData.Response) {
        let viewModel = ListOperations.FetchInitialData.ViewModel(
            calendarDays: response.calendarDays,
            operations: response.operations,
            categories: response.categories
        )
        
        viewController?.displayFetchedInitialData(viewModel: viewModel)
    }
    
    func presentFetchedWeekOfCalendar(request: ListOperations.FetchWeekOfCalendar.Response) {
        let viewModel = ListOperations.FetchWeekOfCalendar.ViewModel(
            calendarDays: request.calendarDays
        )
        
        viewController?.displayFetchedWeekOfCalendar(viewModel: viewModel)
    }
}
