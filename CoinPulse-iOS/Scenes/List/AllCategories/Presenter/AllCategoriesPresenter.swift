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
        let viewModel = AllCategories.FetchCategories.ViewModel(categories: response.categories)
        viewController?.displayFetchedCategories(viewModel: viewModel)
    }
}
