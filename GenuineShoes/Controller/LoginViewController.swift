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
            showMainVCOnRoot()

            
        }
    }
    
   

    func currentUser() -> User? {
        return Auth.auth().currentUser
    }
    
    private lazy var googleLoginBtn: UIButton = {
        let button = UIButton()
        button.setTitle("구글로 로그인", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        button.setTitleColor(UIColor.label, for: .normal)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.label.cgColor
        button.addTarget(self, action: #selector(googleLoginBtnTapped), for: .touchUpInside)
        button.setImage(UIImage(named: "logo_google"), for: .normal)
        return button
        
    }()
    
    @objc func googleLoginBtnTapped(){
        
        GIDSignIn.sharedInstance().signIn()
        
        
        
    }
    
    
    private lazy var logoLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        GIDSignIn.sharedInstance().presentingViewController = self
        GIDSignIn.sharedInstance().delegate = self
        // Do any additional setup after loading the view.
        print("running")
        
        
        //        googleLoginBtn.layer.cornerRadius = 7
        //        googleLoginBtn.layer.borderColor = UIColor.label.cgColor
        //        googleLoginBtn.layer.borderWidth = 1
        //        emailLoginBtn.layer.cornerRadius = 7
        //        emailLoginBtn.layer.borderColor = UIColor.label.cgColor
        //        emailLoginBtn.layer.borderWidth = 1
        
        view.addSubview(googleLoginBtn)
        googleLoginBtn.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-30)
            make.height.equalTo(60)
            make.width.equalTo(300)
            make.centerX.equalTo(view)
        }
        
        
        if currentUser() != nil {
            //showMainViewController()
            print("--------->이미 로그인됨")
           showMainVCOnRoot()
            //self.present(TabController(), animated: false)
            
            //self.navigationController?.pushViewController(TabController(), animated: true)
            
            
        }else {
            print("-------->로그인 재시도")
        }
        
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

