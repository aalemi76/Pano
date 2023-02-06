//
//  SceneDelegate.swift
//  Pano
//
//  Created by AliReza on 2023-02-06.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator: ApplicationCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let navController = UINavigationController()
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        appCoordinator = ApplicationCoordinator(type: .app, navigationController: navController)
        appCoordinator?.start()
    }

}

