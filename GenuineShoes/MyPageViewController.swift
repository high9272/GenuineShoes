//
//  MyPageViewController.swift
//  GenuineShoes
//
//  Created by DaWoon Jeong on 2022/06/28.
//

import Foundation
import UIKit
import Firebase
import GoogleSignIn


class MyPageViewController: UIViewController {
    @IBOutlet weak var logoutBtn: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func logoutBtnTapped(_ viewController: UIViewController) {
        do {
            try Auth.auth().signOut()
            //viewController.navigationController?.popToRootViewController(animated: false)

            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let mainViewController = storyboard.instantiateViewController(identifier: "LoginViewController")
            mainViewController.modalPresentationStyle = .fullScreen
            present(mainViewController, animated: false)
            
        } catch let signOutError as NSError {
            print("ERROR: signout \(signOutError.localizedDescription)")
        }
        
    }

    
    
}
