//
//  SceneDelegate.swift
//  ITunesMovies
//
//  Created by Андрей Соколов on 01.03.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let nav = UINavigationController(rootViewController: MovieSearchViewController())
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
    }
}

