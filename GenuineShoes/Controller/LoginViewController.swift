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
    
    //var showVC = ShowViewController()
    
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
        return button

    }()

    @objc func googleLoginBtnTapped(){
        GIDSignIn.sharedInstance().signIn()
        
        //self.navigationController?.pushViewController(TabController(), animated: false)

    }
    
    //@IBOutlet weak var googleLoginBtn: UIButton!
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.height.equalTo(70)
            make.width.equalTo(300)
            make.centerX.equalTo(view)
        }
        
        
        if currentUser() != nil {
            //showMainViewController()
            print("--------->이미 로그인됨")
            //presentingViewController?.present(TabController(), animated: false)
            

        }else {
            print("로그인 재시도")
        }

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        GIDSignIn.sharedInstance().presentingViewController = self
        //navigationController?.navigationBar.isHidden = true
        GIDSignIn.sharedInstance().restorePreviousSignIn()
        
    }
//    @IBAction func googleLoginBtnTapped(_ sender: UIButton) {
//        GIDSignIn.sharedInstance().signIn()
//
//    }
    
    
    
     func showMainViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainViewController = storyboard.instantiateViewController(identifier: "TabController")
        mainViewController.modalPresentationStyle = .fullScreen
        UIApplication.shared.windows.first?.rootViewController?.show(mainViewController, sender: nil)
    }
    
    
}

