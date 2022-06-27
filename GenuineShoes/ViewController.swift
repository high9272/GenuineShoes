//
//  ViewController.swift
//  GenuineShoes
//
//  Created by DaWoon Jeong on 2022/06/27.
//

import UIKit
import Firebase
import GoogleSignIn

class ViewController: UIViewController {
    @IBOutlet weak var googleLoginBtn: UIButton!
    
    @IBOutlet weak var emailLoginBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("running")
    }
    @IBAction func googleLoginBtnTapped(_ sender: UIButton) {
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let signInConfig = GIDConfiguration.init(clientID: clientID)
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { user, error in
            guard error == nil else { return }
            
            guard let authentication = user?.authentication else { return }
            let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken!, accessToken: authentication.accessToken)
            // access token 부여 받음
            
            // 파베 인증정보 등록
            Auth.auth().signIn(with: credential) {_,_ in
                // token을 넘겨주면, 성공했는지 안했는지에 대한 result값과 error값을 넘겨줌
                self.showMainViewController()
            }
        }
    }
    
    private func showMainViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let mainViewController = storyboard.instantiateViewController(identifier: "TabBarController")
        mainViewController.modalPresentationStyle = .fullScreen
        
        UIApplication.shared.windows.first?.rootViewController?.show(mainViewController, sender: nil)
    }
    

}

