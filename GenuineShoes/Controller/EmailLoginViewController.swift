//
//  EmailLoginViewController.swift
//  GenuineShoes
//
//  Created by DaWoon Jeong on 2022/07/15.
//

import Foundation
import UIKit
import SnapKit
import FirebaseAuth


class EmailLoginViewController: UIViewController {
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "이메일을 입력해주세요"
        textField.textAlignment = .left
        textField.layer.borderColor = UIColor.label.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 5
        textField.keyboardType = .emailAddress
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "비밀번호를 입력해주세요"
        textField.textAlignment = .left
        textField.layer.borderColor = UIColor.label.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 5
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private lazy var loginBtn: UIButton = {
        let button = UIButton()
        button.setTitle("LOGIN", for: .normal)
        button.setTitleColor(UIColor.systemBackground, for: .normal)
        button.backgroundColor = .label
        button.layer.borderColor = UIColor.label.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(loginBtnTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func loginBtnTapped(){
        
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
                   
                    self.errorLabel.text = error.localizedDescription
                }
            } else {

                print("이메일 로그인 버튼 클릭")
                self.dismiss(animated: false, completion: nil)
            }
        }
        
    }
    
    
    lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemRed
        return label
    }()
    
    
    
    
    
    
    func loginUser(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) {[weak self] _, error in
            guard let self = self else { return }
            
            if let error = error {
                print("\(error.localizedDescription)")
            } else {
               
            }
        }
    }
    
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.emailTextField.becomeFirstResponder()
        
        setupLayout()
        
    }
    
    
    func setupLayout(){
        [emailTextField,passwordTextField,loginBtn,errorLabel].forEach {view.addSubview($0)}
        //view.addSubview(emailTextField)
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(150)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(50)
        }
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(25)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(50)
        }
        
        errorLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(40)
        }
        
        loginBtn.snp.makeConstraints { make in
            make.top.equalTo(errorLabel.snp.bottom).offset(50)
            make.centerX.equalTo(view)
            make.height.equalTo(50)
            make.width.equalTo(100)
        }
        
        
        
        
        

    }
}

extension EmailLoginViewController: UITextFieldDelegate {
    //키보드 내려가기
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let isEmailEmpty = self.emailTextField.text == ""
        let isPasswordEmpty = self.passwordTextField.text == ""
        self.loginBtn.isEnabled = !isEmailEmpty && !isPasswordEmpty
    }
}




