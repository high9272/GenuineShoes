//
//  showViewController.swift
//  GenuineShoes
//
//  Created by DaWoon Jeong on 2022/07/05.
//

import Foundation
import UIKit

func showMainVCOnRoot(){

    let mainVC = TabController()
    mainVC.modalPresentationStyle = .fullScreen
    //UIApplication.shared.windows.first?.rootViewController?.show(mainVC, sender: nil)
    UIApplication.shared.windows.first?.rootViewController?.present(mainVC, animated: false)
}


func showLoginVCOnRoot(){
    let mainVC = LoginViewController()
    mainVC.modalPresentationStyle = .fullScreen
    
    //UIApplication.shared.windows.first?.rootViewController?.show(mainVC, sender: nil)
    UIApplication.shared.windows.first?.rootViewController?.present(mainVC, animated: false)
}
