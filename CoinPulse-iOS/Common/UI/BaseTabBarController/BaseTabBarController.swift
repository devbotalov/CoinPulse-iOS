//
//  BaseTabBarController.swift
//  CoinPulse-iOS
//
//  Created by Maksim Botalov on 07.10.2024.
//

import UIKit

final class BaseTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarController()
    }
}

private extension BaseTabBarController {
    func setupTabBarController() {
        let addScene = createNavigationController(
            tabBarItem: TabBarItem(
                navigationBarTitle: "Navigation Add",
                tabBarTitle: "TabBar Add",
                tabBarImage: UIImage(systemName: "plus"),
                rootViewController: UIViewController()
            )
        )
        
        setViewControllers(
            [addScene],
            animated: false
        )
    }
    
    func createNavigationController(tabBarItem: TabBarItemProtocol) -> UINavigationController {
        tabBarItem.rootViewController.navigationItem.title = tabBarItem.navigationBarTitle
        tabBarItem.rootViewController.tabBarItem.title = tabBarItem.tabBarTitle
        tabBarItem.rootViewController.tabBarItem.image = tabBarItem.tabBarImage
        return UINavigationController(rootViewController: tabBarItem.rootViewController)
    }
}
