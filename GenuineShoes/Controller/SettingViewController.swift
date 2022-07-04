//
//  SettingViewController.swift
//  GenuineShoes
//
//  Created by DaWoon Jeong on 2022/07/04.
//

import Foundation
import UIKit
import SnapKit
import Firebase
import GoogleSignIn
import FirebaseDatabase

class SettingViewController: UIViewController {
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그아웃", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        button.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    @objc func logoutButtonTapped(){
        
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
    }
    
    func setupLayout(){
        view.addSubview(logoutButton)
        logoutButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.width.equalTo(100)
            make.height.equalTo(50)
            make.centerX.equalTo(view)
        }
    }
    
}
