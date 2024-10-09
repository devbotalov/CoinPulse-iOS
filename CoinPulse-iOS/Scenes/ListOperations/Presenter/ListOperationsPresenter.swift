//
//  ListOperationsPresenter.swift
//  CoinPulse-iOS
//
//  Created by Maksim Botalov on 07.10.2024.
//

import Foundation

final class ListOperationsPresenter: ListOperations.PresentationLogic {
    var viewController: ListOperations.DisplayLogic?
    
    func presentFetchedData(response: ListOperations.FetchData.Response) {
        let viewModel = ListOperations.FetchData.ViewModel(
            operations: response.operations,
            categories: response.categories
        )
        
        viewController?.displayFetchedData(viewModel: viewModel)
    }
}
