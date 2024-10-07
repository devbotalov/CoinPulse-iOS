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
        var viewControllers: [UIViewController] = []
        
        if let addViewController = serviceLocator?.resolve() as AddOperation.ViewController? {
            let addScene = setupNavigationController(
                tabBarItem: TabBarItem(
                    navigationBarTitle: "Navigation Add",
                    tabBarTitle: "TabBar Add",
                    tabBarImage: UIImage(systemName: "plus"),
                    rootViewController: addViewController
                )
            )
            
            viewControllers.append(addScene)
        }
        
        setViewControllers(viewControllers,animated: false)
    }
    
    func setupNavigationController(tabBarItem: TabBarItemProtocol) -> UINavigationController {
        tabBarItem.rootViewController.navigationItem.title = tabBarItem.navigationBarTitle
        tabBarItem.rootViewController.tabBarItem.title = tabBarItem.tabBarTitle
        tabBarItem.rootViewController.tabBarItem.image = tabBarItem.tabBarImage
        return UINavigationController(rootViewController: tabBarItem.rootViewController)
    }
}
