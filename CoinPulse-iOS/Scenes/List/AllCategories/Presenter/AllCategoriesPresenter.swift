//
//  AllCategoriesPresenter.swift
//  CoinPulse-iOS
//
//  Created by Maksim Botalov on 15.10.2024.
//

import Foundation

final class AllCategoriesPresenter: AllCategories.PresentationLogic {
    var viewController: AllCategories.DisplayLogic?
    
    func presentFetchedCategories(response: AllCategories.FetchCategories.Response) {
        let viewModel = AllCategories.FetchCategories.ViewModel(
            expenseCategories: response.expenseCategories,
            incomeCategories: response.incomeCategories
        )
        viewController?.displayFetchedCategories(viewModel: viewModel)
    }
}
