//
//  SceneDelegate.swift
//  Schedule A Timer
//
//  Created by Saurabh Gupta on 15/07/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?


  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    window = UIWindow(windowScene: windowScene)
    window?.makeKeyAndVisible()
    
    let viewController = MainViewController()
    window?.rootViewController = UINavigationController(rootViewController: viewController)
  }

}

