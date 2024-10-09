//
//  ListOperationsInteractor.swift
//  CoinPulse-iOS
//
//  Created by Maksim Botalov on 07.10.2024.
//

import Foundation

final class ListOperationsInteractor: ListOperations.BusinessLogic {
    var presenter: ListOperations.PresentationLogic?
    
    private(set) var operations: [OperationEntity] = []
    private(set) var categories: [CategoryEntity] = []
    
    private var coreDataManager: CoreDataManagerProtocol = CoreDataManager.shared
    
    func fetchData(request: ListOperations.FetchData.Request) {
        do {
            operations = try coreDataManager.fetchOperations(with: request.operationsPredicate)
            categories = try coreDataManager.fetchCategories(with: request.categoriesPredicate)
            
            let response = ListOperations.FetchData.Response(
                operations: operations,
                categories: categories
            )
            
            presenter?.presentFetchedData(response: response)
        } catch let error {
            // FIXME: Display notifications error
            print("===", error.localizedDescription)
        }
    }
}
