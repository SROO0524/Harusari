//
//  SignUpVC.swift
//  Harusali
//
//  Created by 김믿음 on 2020/07/14.
//  Copyright © 2020 김믿음. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore


//MARK: Sign up 화면 

class SignUpVC: UIViewController {
    
    // MARK: Property
    let loginVC = SignInVC()
    let firestore = Firestore.firestore()
    
    
    let balance : String = "0"
    
    let nameTextField : UITextField = {
        let nameTextField = UITextField()
        nameTextField.placeholder = "이름을 적어주세요"
        nameTextField.borderStyle = .roundedRect
        return nameTextField
    }()
    
    
    let emailTextField : UITextField = {
        let emailTextField = UITextField()
        emailTextField.placeholder = "이메일을 적어주세요"
        emailTextField.borderStyle = .roundedRect
        return emailTextField
    }()
    
    
    let passWordTextField : UITextField = {
        let passWordTextField = UITextField()
        passWordTextField.placeholder = "비밀번호를 설정해주세요"
        passWordTextField.isSecureTextEntry = true
        passWordTextField.borderStyle = .roundedRect
        return passWordTextField
    }()
    
    let signUpBT : UIButton = {
        let signUpBT = UIButton()
        signUpBT.setTitle("가입하기", for: .normal)
        signUpBT.layer.cornerRadius = 10
        signUpBT.backgroundColor = .systemGray
        signUpBT.addTarget(self, action: #selector(signUpBtTap), for: .touchUpInside)
        return signUpBT
    }()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "회원가입"
        
        setUpConstraints()
    }
    
    // MARK: KeyBoard UP
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
        
    }
    
    // MARK: @Objc
    @objc func signUpBtTap(_ sender : UIButton){
        
        guard let email = emailTextField.text, let password = passWordTextField.text
            , let name = nameTextField.text else {return}
        signUp(email: email,password: password, name: name, balance: balance) { (result) in
            switch result {
            case .failure:
                self.failureSignUpAlert()
            case .success:
                self.successSignUpAlert()
            }
        }
    }
    
    
// MARK: SignUP Func
    //     *** balance : 잔액
    private func signUp(email: String, password: String, name: String, balance: String, completion: @escaping (Result<String,Error>) -> ()) {
        
        guard let email = self.emailTextField.text else {
            return
        }
        guard let password = self.passWordTextField.text else {
            return
        }
        
        
        Auth.auth().createUser(withEmail: email, password: password) {( result, error
            ) in
            if let error = error {
                print("회원가입 불가")
                completion(.failure(error))
            } else {
                print("회원가입 성공")
                guard let user = result?.user else {return}
                self
                    .firestore
                    .collection("User")
                    .document(user.uid)
                    .setData([
                        UserReference.email : email,
                        UserReference.name : name,
                        UserReference.balance : balance
                        
                    ]) {(error) in
                        if let error = error {
                            completion(.failure(error))
                        } else {
                            completion(.success("Success"))
                        }
                }
                
            }
            
        }
    }
    
// MARK: signUp Alert Func
    // 회원가입 성공시 뜨는 알럿
    private func successSignUpAlert(title: String? = nil, message: String? = nil, handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: "알림", message: "회원가입 하시겠습니까?", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "확인", style: .destructive) { (action) in self.backToLogin()}
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        present(alert,animated: false,completion: nil)
        
    }
    
    // 회원가입 실패시 뜨는 알럿
    private func failureSignUpAlert(title: String? = nil, message: String? = nil, handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: "알림", message: "다시 입력해주세요!", preferredStyle: UIAlertController.Style.alert)
        let cancelAction = UIAlertAction(title: "확인", style: .cancel, handler: nil)
        
        alert.addAction(cancelAction)
        present(alert,animated: false,completion: nil)
        
    }
    
    // 회원가입 성공시 LoginVC 로 돌아가는 Func
    private func backToLogin(){
        
        //        self.navigationItem.title = "로그인"
        self.navigationController?.navigationBar.topItem?.title = "로그인"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.popViewController(animated: true)
        self.navigationController?.modalPresentationStyle = .automatic
    }
    
    
// MARK: SetUpConstraints
    private func setUpConstraints() {
        
        [nameTextField,passWordTextField,emailTextField,signUpBT].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            nameTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10),
            emailTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            passWordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10),
            passWordTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            passWordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            signUpBT.topAnchor.constraint(equalTo: passWordTextField.bottomAnchor, constant: 20),
            signUpBT.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            signUpBT.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
