//
//  AllCategoriesInteractor.swift
//  CoinPulse-iOS
//
//  Created by Maksim Botalov on 15.10.2024.
//

import Foundation

final class AllCategoriesInteractor: AllCategories.BusinessLogic {
    var presenter: AllCategories.PresentationLogic?
    
    private(set) var expenseCategories: [CategoryEntity] = []
    private(set) var incomeCategories: [CategoryEntity] = []
    
    private var coreDataManager: CoreDataManagerProtocol = CoreDataManager.shared
    
    func fetchCategories(request: AllCategories.FetchCategories.Request) {
        do {
            
            
            let expenseCategoriesPredicate = NSPredicate(
                format: "ANY operations.type == %@", OperationType.expense.rawValue
            )
            
            let incomeCategoriesPredicate = NSPredicate(
                format: "ANY operations.type == %@", OperationType.income.rawValue
            )
            
            expenseCategories = try coreDataManager.fetchCategories(with: expenseCategoriesPredicate)
            incomeCategories = try coreDataManager.fetchCategories(with: incomeCategoriesPredicate)
            
            let response = AllCategories.FetchCategories.Response(
                expenseCategories: expenseCategories,
                incomeCategories: incomeCategories
            )
            presenter?.presentFetchedCategories(response: response)
        } catch let error {
            // FIXME: Display notifications error
            print("===", error.localizedDescription)
        }
    }
}

