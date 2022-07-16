//
//  TabController.swift
//  GenuineShoes
//
//  Created by DaWoon Jeong on 2022/07/04.
//

import Foundation
import SnapKit
import UIKit
import Firebase
import FirebaseAuth



class TabController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfUserIsLoggedIn()
        
        
        //self.navigationItem.setHidesBackButton(true, animated: true)
        
        
        let collectionViewController = UINavigationController(rootViewController: HomeCollectionViewController())
        collectionViewController.tabBarItem = UITabBarItem(title: "SAMPLE", image:UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house"))
        
        
//        let homeViewController = UINavigationController(rootViewController: HomeViewController())
//        homeViewController.tabBarItem = UITabBarItem(title: "HOME", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        
        let searchViewController = UINavigationController(rootViewController: SearchViewController())
        searchViewController.tabBarItem = UITabBarItem(title: "SEARCH", image: UIImage(systemName: "magnifyingglass"), selectedImage: UIImage(systemName: "magnifyingglass"))
        
        let myPageViewController = UINavigationController(rootViewController: MyPageViewController())
        myPageViewController.tabBarItem = UITabBarItem(title: "MY", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person"))
        
        
        
        viewControllers = [collectionViewController, searchViewController, myPageViewController]
        
        
    }
    
    
    func checkIfUserIsLoggedIn(){
    
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let controller = LoginViewController()
                let nav = UINavigationController(rootViewController: controller)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: false, completion: nil)
            }

            
        }
        
        
    }
}
