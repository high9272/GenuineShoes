//
//  EmailLoginViewController.swift
//  GenuineShoes
//
//  Created by DaWoon Jeong on 2022/06/28.
//

import Foundation
import UIKit
import FirebaseAuth

class EmailLoginViewController: UIViewController, UITextFieldDelegate {
 
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var nextButton: UIButton!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.emailTextField.delegate = self
        
    }
    
    @IBAction func nextButtonAction(_ sender: UIButton) {
        
        let email = self.emailTextField.text ?? ""
        let password = self.passwordTextField.text ?? ""
        
        //신규 사용자 생성
        Auth.auth().createUser(withEmail: email, password: password) {[weak self] authResult, error in
            guard let self = self else { return }
            
            if let error = error {
                let code = (error as NSError).code
                switch code {
                case 17007: //이미 가입한 계정일 때
                    self.loginUser(withEmail: email, password: password)
                default:
                    print("sdsd")
                }
            } else {
                self.showMainViewController()
            }
        }
        
        
    }
    
    func loginUser(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) {[weak self] _, error in
            guard let self = self else { return }
            
            if let error = error {
                //self.errorDescriptionLabel.text = error.localizedDescription
            } else {
                self.showMainViewController()
            }
        }
    }
    
    func showMainViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let mainViewController = storyboard.instantiateViewController(identifier: "TabBarController")
        mainViewController.modalPresentationStyle = .fullScreen
        self.navigationController?.show(mainViewController, sender: nil)
    }
    
    
    
}
