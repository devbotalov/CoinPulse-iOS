//
//  SceneDelegate.swift
//  CoinPulse-iOS
//
//  Created by Maksim Botalov on 06.10.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var serviceLocator: ServiceLocatorProtocol?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        setupLocator()
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = BaseTabBarController(serviceLocator: serviceLocator)
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}


private extension SceneDelegate {
    private func setupLocator() {
        serviceLocator = ServiceLocator.shared
        registerDependencies(in: serviceLocator)
    }
    
    private func registerDependencies(in serviceLocator: ServiceLocatorProtocol?) {
        guard let serviceLocator else { return }
        
        AddOperation.Configurator.registerDependencies(in: serviceLocator)
        ListOperations.Configurator.registerDependencies(in: serviceLocator)
        AllCategories.Configurator.registerDependencies(in: serviceLocator)
        AddCategory.Configurator.registerDependencies(in: serviceLocator)
        Profile.Configurator.registerDependencies(in: serviceLocator)
    }
}
