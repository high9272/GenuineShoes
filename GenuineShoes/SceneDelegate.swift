//
//  SceneDelegate.swift
//  GenuineShoes
//
//  Created by DaWoon Jeong on 2022/06/27.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
//        let loginViewController = UINavigationController(rootViewController: LoginViewController())
        
        window = UIWindow(windowScene: windowScene)
        window?.backgroundColor = .systemBackground
        window?.rootViewController = TabController() // 루트뷰 컨트롤러를 아예 탭 컨트롤러로 변경
        window?.tintColor = .label
        window?.makeKeyAndVisible()
        
        
        
        
        
    }




}

