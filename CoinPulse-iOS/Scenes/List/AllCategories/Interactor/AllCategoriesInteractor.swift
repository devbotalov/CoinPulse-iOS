//
//  AllCategoriesInteractor.swift
//  CoinPulse-iOS
//
//  Created by Maksim Botalov on 15.10.2024.
//

import Foundation

final class AllCategoriesInteractor: AllCategories.BusinessLogic {
    var presenter: AllCategories.PresentationLogic?
    
    private(set) var categories: [CategoryEntity] = []
    
    private var coreDataManager: CoreDataManagerProtocol = CoreDataManager.shared
    
    func fetchCategories(request: AllCategories.FetchCategories.Request) {
        do {
            categories = try coreDataManager.fetchCategories(with: nil)
            
            let response = AllCategories.FetchCategories.Response(categories: categories)
            presenter?.presentFetchedCategories(response: response)
        } catch let error {
            // FIXME: Display notifications error
            print("===", error.localizedDescription)
        }
    }
}

