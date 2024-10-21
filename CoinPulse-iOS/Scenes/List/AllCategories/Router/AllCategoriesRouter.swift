//
//  AllCategoriesRouter.swift
//  CoinPulse-iOS
//
//  Created by Maksim Botalov on 15.10.2024.
//

import UIKit

final class AllCategoriesRouter: AllCategories.RoutingLogic {
    var viewController: AllCategories.DisplayLogic?
    var dataStore: AllCategories.DataStore?
    
    private let serviceLocator = ServiceLocator.shared
    
    func routeToAddCategory() {
        guard
            let source = viewController as? AllCategories.ViewController,
            let destination = serviceLocator.resolve() as AddCategory.ViewController?
        else { return }
        
        navigateToAddCategory(source: source, destination: destination)
    }
}

private extension AllCategories.Router {
    func navigateToAddCategory(source: AllCategories.ViewController, destination: AddCategory.ViewController) {
        let customDetent = UISheetPresentationController.Detent.custom { _ in
            destination.calculatePreferredSize().height
        }
        
        if let sheet = destination.sheetPresentationController {
            sheet.detents = [customDetent]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 12
        }
        
        source.present(destination, animated: true)
    }
}
