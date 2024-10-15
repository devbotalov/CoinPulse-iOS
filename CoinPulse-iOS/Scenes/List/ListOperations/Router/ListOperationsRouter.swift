//
//  ListOperationsRouter.swift
//  CoinPulse-iOS
//
//  Created by Maksim Botalov on 07.10.2024.
//

import Foundation

final class ListOperationsRouter: ListOperations.RoutingLogic {
    var viewController: ListOperations.DisplayLogic?
    var dataStore: ListOperations.DataStore?
    
    func routeToAllCategories() {
        guard let source = viewController as? ListOperations.ViewController else { return }
        
        let destination = AllCategoriesViewController()
        destination.hidesBottomBarWhenPushed = true
        
        navigateToAllCategories(source: source, destination: destination)
    }
}

private extension ListOperations.Router {
    func navigateToAllCategories(source: ListOperations.ViewController, destination: AllCategories.ViewController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }
}
