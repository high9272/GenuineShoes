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
import FirebaseAuth
import FirebaseDatabase
class MyPageViewController: UIViewController {
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        return label
        
    }()

    private lazy var logoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그아웃", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.setTitleColor(UIColor.systemPink, for: .normal)
        button.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그인하러 가기", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    
    
    @objc func logoutButtonTapped(_ viewController: UIViewController) {
        
        do {
            try Auth.auth().signOut()
            print("로그아웃")
            
            //MARK: 뷰컨트롤러 이동 코드
            let controller = LoginViewController()
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: false, completion: nil)
            
            
        } catch let signOutError as NSError {
            print("ERROR: signout \(signOutError.localizedDescription)")
        }
        
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let displayName = Auth.auth().currentUser?.email ?? ""
        
        if displayName.isEmpty {//로그인이 안된 상태
            emailLabel.isHidden = true 
            logoutButton.isHidden = true
            loginButton.isHidden = false
            
        }else{ //로그인이 된 상태
            emailLabel.isHidden = false
            loginButton.isHidden = true
            logoutButton.isHidden = false
            self.emailLabel.text = "\(displayName)님 안녕하세요😊"
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        setupLayout()
    }
    
    func setupLayout(){
        [logoutButton, emailLabel, loginButton].forEach {view.addSubview($0)}
        logoutButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
            make.width.equalTo(200)
            make.height.equalTo(50)
            make.centerX.equalTo(view)
        }
        
        loginButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
            make.width.equalTo(200)
            make.height.equalTo(50)
            make.centerX.equalTo(view)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(30)
            
        }
    }
    
}
