//
//  SceneDelegate.swift
//  OS_Alfa_first
//
//  Created by Нелли Першина on 09.10.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
//        guard - срабатывает, когда условие ложно, обратный if:
//        if (windowScene = (scene as? UIWindowScene)) == nil  { return }
//        return
        let window = UIWindow(windowScene: windowScene)
        let viewController = ViewController()
        window.rootViewController = viewController
        window.makeKeyAndVisible()
        self.window = window // присваиваем к глобал(12 строка)
    }
}
