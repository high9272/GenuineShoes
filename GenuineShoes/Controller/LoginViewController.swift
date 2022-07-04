//
//  ViewController.swift
//  GenuineShoes
//
//  Created by DaWoon Jeong on 2022/06/27.
//

import UIKit
import Firebase
import GoogleSignIn
import SnapKit

class LoginViewController: UIViewController {
    
    func currentUser() -> User? {
        return Auth.auth().currentUser
    }
    
//    private lazy var sampleBtn: UIButton = {
//        let button = UIButton()
//        button.setTitle("버튼입니다", for: .normal)
//        button.backgroundColor = .blue
//        button.addTarget(self, action: #selector(sampleBtnTapped), for: .touchUpInside)
//        return button
//
//    }()
//
//    @objc func sampleBtnTapped(){
//        GIDSignIn.sharedInstance().signIn()
//
//    }
    
    @IBOutlet weak var googleLoginBtn: UIButton!
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("running")
        
        
        googleLoginBtn.layer.cornerRadius = 7
        googleLoginBtn.layer.borderColor = UIColor.label.cgColor
        googleLoginBtn.layer.borderWidth = 1
//        emailLoginBtn.layer.cornerRadius = 7
//        emailLoginBtn.layer.borderColor = UIColor.label.cgColor
//        emailLoginBtn.layer.borderWidth = 1
        
//        view.addSubview(sampleBtn)
//        sampleBtn.snp.makeConstraints { make in
//            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
//            make.height.equalTo(100)
//            make.width.equalTo(100)
//        }
        
        
        if currentUser() != nil {
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let mainViewController = storyboard.instantiateViewController(identifier: "MyPageViewController")
            mainViewController.modalPresentationStyle = .fullScreen
            self.navigationController?.show(mainViewController, sender: nil)
            print("이미 로그인 됨")
            
            
        }
        
        
        
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        GIDSignIn.sharedInstance().presentingViewController = self
        //navigationController?.navigationBar.isHidden = true
        
    }
    @IBAction func googleLoginBtnTapped(_ sender: UIButton) {
        GIDSignIn.sharedInstance().signIn()
        
    }
    
    
    
    private func showMainViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let mainViewController = storyboard.instantiateViewController(identifier: "MyPageViewController")
        mainViewController.modalPresentationStyle = .fullScreen
        UIApplication.shared.windows.first?.rootViewController?.show(mainViewController, sender: nil)
    }
    
    
}

