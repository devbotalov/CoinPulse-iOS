//
//  BaseTabBarController.swift
//  CoinPulse-iOS
//
//  Created by Maksim Botalov on 07.10.2024.
//

import UIKit

final class BaseTabBarController: UITabBarController {
    
    private var serviceLocator: ServiceLocatorProtocol?
    
    init(serviceLocator: ServiceLocatorProtocol?) {
        self.serviceLocator = serviceLocator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarController(serviceLocator: serviceLocator)
    }
}

private extension BaseTabBarController {
    func setupTabBarController(serviceLocator: ServiceLocatorProtocol?) {
        UITabBar.appearance().tintColor = UIColor(resource: .accentBlue)
        UITabBar.appearance().unselectedItemTintColor = UIColor(resource: .accentGray)
        
        tabBar.isTranslucent = true
        
        var navigationControllers = [UINavigationController]()
        
        if let addOperationViewController = serviceLocator?.resolve() as AddOperation.ViewController? {
            let addOperationNavigationController = setupNavigationController(
                tabBarItem: TabBarItem(
                    navigationBarTitle: "Add a new operation",
                    tabBarTitle: "Add",
                    tabBarImage: UIImage(systemName: "plus"),
                    rootViewController: addOperationViewController
                )
            )
            
            navigationControllers.append(addOperationNavigationController)
        }
        
        if let listOperationsViewController = serviceLocator?.resolve() as ListOperations.ViewController? {
            let listOperationsNavigationController = setupNavigationController(
                tabBarItem: TabBarItem(
                    navigationBarTitle: "List of operations",
                    tabBarTitle: "List",
                    tabBarImage: UIImage(systemName: "list.dash"),
                    rootViewController: listOperationsViewController
                )
            )
            
            navigationControllers.append(listOperationsNavigationController)
        }
        
        if let profileViewController = serviceLocator?.resolve() as Profile.ViewController? {
            let profileNavigationController = setupNavigationController(
                tabBarItem: TabBarItem(
                    navigationBarTitle: "Profile",
                    tabBarTitle: "Profile",
                    tabBarImage: UIImage(systemName: "person.fill"),
                    rootViewController: profileViewController
                )
            )
            
            navigationControllers.append(profileNavigationController)
        }
        
        setViewControllers(navigationControllers, animated: false)
    }
    
    func setupNavigationController(tabBarItem: TabBarItemProtocol) -> UINavigationController {
        tabBarItem.rootViewController.navigationItem.title = tabBarItem.navigationBarTitle
        tabBarItem.rootViewController.tabBarItem.title = tabBarItem.tabBarTitle
        tabBarItem.rootViewController.tabBarItem.image = tabBarItem.tabBarImage
        return UINavigationController(rootViewController: tabBarItem.rootViewController)
    }
}
