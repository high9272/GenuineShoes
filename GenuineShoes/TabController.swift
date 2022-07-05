//
//  TabController.swift
//  GenuineShoes
//
//  Created by DaWoon Jeong on 2022/07/04.
//

import Foundation
import SnapKit
import UIKit

let mainstoryboard = UIStoryboard(name: "TabController", bundle: nil)

class TabController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.navigationItem.setHidesBackButton(true, animated: true)
        
        
        let homeViewController = UINavigationController(rootViewController: HomeViewController())
        homeViewController.tabBarItem = UITabBarItem(title: "HOME", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        
        let searchViewController = UINavigationController(rootViewController: SearchViewController())
        searchViewController.tabBarItem = UITabBarItem(title: "SEARCH", image: UIImage(systemName: "magnifyingglass"), selectedImage: UIImage(systemName: "magnifyingglass"))
        
        let myPageViewController = UINavigationController(rootViewController: MyPageViewController())
        myPageViewController.tabBarItem = UITabBarItem(title: "MY", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person"))
        
        
        
        viewControllers = [homeViewController, searchViewController, myPageViewController]
        
        
    }
    
}
