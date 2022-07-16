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

class LoginViewController: UIViewController, GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print("Error because \(error.localizedDescription)")
            return
        }
        
        guard let auth = user.authentication else {return}
        let credentails = GoogleAuthProvider.credential(withIDToken: auth.idToken, accessToken: auth.accessToken)
        
        Auth.auth().signIn(with: credentails) { (authResult,error) in
            if let error = error {
                print("error \(error.localizedDescription)")
                
                return
            }
            print("-------->로그인 성공")
//            showMainVCOnRoot()
            self.dismiss(animated: true, completion:  nil)

            
        }
    }
    
   

    func currentUser() -> User? {
        return Auth.auth().currentUser
    }
    
    private lazy var googleLoginBtn: UIButton = {
        let button = UIButton()
        button.setTitle("구글로 로그인", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.setTitleColor(UIColor.label, for: .normal)
        button.contentHorizontalAlignment = .center
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.label.cgColor
        button.addTarget(self, action: #selector(googleLoginBtnTapped), for: .touchUpInside)
        button.setImage(UIImage(named: "logo_google"), for: .normal)
        //button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -20)
        
        return button
        
    }()
    @objc func googleLoginBtnTapped(){
        
        GIDSignIn.sharedInstance().signIn()

    }
    
    
    private lazy var emailLoginBtn: UIButton = {
        let button = UIButton()
        button.setTitle("이메일로 로그인", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.setTitleColor(UIColor.label, for: .normal)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.label.cgColor
        button.setImage(UIImage(systemName: "envelope.fill"), for: .normal)
        button.contentHorizontalAlignment = .center
        button.addTarget(self, action: #selector(emailLoginBtnTapped), for: .touchUpInside)
        
        //button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -20)
        return button
        
    }()
    
    @objc func emailLoginBtnTapped(){
        self.navigationController?.pushViewController(EmailLoginViewController(), animated: true)
    }
    
    
    
    
    private lazy var loginSkipBtn: UIButton = {
        let button = UIButton()
        button.setTitle("로그인 건너뛰기", for: .normal)
        button.setTitleColor(UIColor.systemGray2, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        button.addTarget(self, action: #selector(loginSkipBtnTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func loginSkipBtnTapped(){
        showMainVCOnRoot()
    }
    
    
    lazy var logoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Copperplate-Bold", size: 25)
        label.text = "GenuineShoes"
        label.textAlignment = .center
        return label
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        self.navigationItem.setHidesBackButton(true, animated: true)
        GIDSignIn.sharedInstance().presentingViewController = self
        GIDSignIn.sharedInstance().delegate = self
        // Do any additional setup after loading the view.
        print("running")
        

        
        

        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//
//
//
//        if currentUser() != nil {
//            //showMainViewController()
//            print("--------->이미 로그인됨")
//           showMainVCOnRoot()
//            //self.present(TabController(), animated: false)
//            
//            //self.navigationController?.pushViewController(TabController(), animated: true)
//
//
//        }else {
//            print("-------->로그인 재시도")
//        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        GIDSignIn.sharedInstance().presentingViewController = self
        //navigationController?.navigationBar.isHidden = true
        //GIDSignIn.sharedInstance().restorePreviousSignIn()
        
    }
    
    
    
    //    func showMainViewController() {
    //        let storyboard = UIStoryboard(name: "Main", bundle: nil)
    //        let mainViewController = storyboard.instantiateViewController(identifier: "TabController")
    //        mainViewController.modalPresentationStyle = .fullScreen
    //        UIApplication.shared.windows.first?.rootViewController?.show(mainViewController, sender: nil)
    //    }
    
    
}

extension LoginViewController {
    func setupLayout(){
        
        [loginSkipBtn, googleLoginBtn, emailLoginBtn, logoLabel].forEach {view.addSubview($0)}
        
        loginSkipBtn.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-100)
            make.height.equalTo(30)
            make.width.equalTo(300)
            make.centerX.equalTo(view)
        }
        
        googleLoginBtn.snp.makeConstraints { make in
            make.bottom.equalTo(loginSkipBtn.snp.top).offset(-35)
            make.height.equalTo(50)
            make.width.equalTo(300)
            make.centerX.equalTo(view)
        }
        
        emailLoginBtn.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(300)
            make.centerX.equalTo(view)
            make.bottom.equalTo(googleLoginBtn.snp.top).offset(-25)
        }
        
        logoLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
            make.centerX.equalTo(view)
        }
        

        
    }
}

