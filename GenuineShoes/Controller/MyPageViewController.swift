//
//  MyPageViewController.swift
//  GenuineShoes
//
//  Created by DaWoon Jeong on 2022/07/05.
//

import Foundation
import UIKit
import SnapKit
import Firebase
import GoogleSignIn
import FirebaseDatabase
class MyPageViewController: UIViewController {
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그아웃", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.setTitleColor(UIColor.gray, for: .normal)
        button.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    @objc func logoutButtonTapped(_ viewController: UIViewController) {
        
        do {
            try Auth.auth().signOut()
            print("로그아웃")

            let controller = LoginViewController()
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: false, completion: nil)
            
            
        } catch let signOutError as NSError {
            print("ERROR: signout \(signOutError.localizedDescription)")
        }
        
        
        
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }
    
    func setupLayout(){
        view.addSubview(logoutButton)
        logoutButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
            make.width.equalTo(100)
            make.height.equalTo(50)
            make.centerX.equalTo(view)
            
   
        }
    }
    
}
