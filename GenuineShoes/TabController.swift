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
        self.delegate = self
        
        //self.navigationItem.setHidesBackButton(true, animated: true)
        
        
        let collectionViewController = UINavigationController(rootViewController: HomeCollectionViewController())
        collectionViewController.tabBarItem = UITabBarItem(title: "HOME", image:UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house"))
        
        //let detailViewController = UINavigationController(rootViewController: DetailViewController())
        
        
//        let homeViewController = UINavigationController(rootViewController: HomeViewController())
//        homeViewController.tabBarItem = UITabBarItem(title: "HOME", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        
        let searchViewController = UINavigationController(rootViewController: SearchViewController())
        searchViewController.tabBarItem = UITabBarItem(title: "SEARCH", image: UIImage(systemName: "magnifyingglass"), selectedImage: UIImage(systemName: "magnifyingglass"))
        
        let myPageViewController = UINavigationController(rootViewController: MyPageViewController())
        myPageViewController.tabBarItem = UITabBarItem(title: "MY", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person"))
        
        let userCheckViewController = UINavigationController(rootViewController: UserCheckViewController())
        userCheckViewController.tabBarItem = UITabBarItem(title: "CHECK", image: UIImage(systemName: "photo"), selectedImage: UIImage(systemName: "photo"))
        
        
        viewControllers = [collectionViewController, searchViewController, userCheckViewController , myPageViewController]
        
        
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
extension TabController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let index = viewControllers?.firstIndex(of: viewController)
        print("\(index)번째 탭을 눌렀습니다")
        
        
        return true
    }
}
