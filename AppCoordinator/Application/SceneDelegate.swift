//
//  SceneDelegate.swift
//  AppCoordinator
//
//  Created by lym on 2023/9/14.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    var appFlowCoordinator: Coordinator?
    var appFactory: AppFactory?
    var appDICoordinator: AppDICoordinator?

    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: scene)
        appDICoordinator = AppDICoordinator()
        appFactory = AppFactory(appDICoordinator: appDICoordinator)
        let navigation = NavigationImp(rootViewController: UINavigationController())
        appFlowCoordinator = AppFlowCoordinator(
            navigation: navigation,
            windown: scene.windows.first,
            factory: appFactory,
            auth: appDICoordinator?.auth
        )
        appFlowCoordinator?.start()

        window?.rootViewController = navigation.rootViewController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
}
