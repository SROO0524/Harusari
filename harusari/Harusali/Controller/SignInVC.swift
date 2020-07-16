//
//  LoginVC.swift
//  Harusali
//
//  Created by 김믿음 on 2020/07/12.
//  Copyright © 2020 김믿음. All rights reserved.
//

import UIKit
import Firebase


// MARK: Login ViewController

class SignInVC: UIViewController {

    
// MARK: Property
    let firestore = Firestore.firestore()

let idTextField : UITextField = {
    let idTextField = UITextField()
    idTextField.borderStyle = .roundedRect
    idTextField.placeholder = "이메일을 적어주세요"
    return idTextField
}()
    

let passWordTextField : UITextField = {
    let passWordTextField = UITextField()
    passWordTextField.borderStyle = .roundedRect
    passWordTextField.placeholder = "비밀번호를 적어주세요"
    passWordTextField.isSecureTextEntry = true
    return passWordTextField
}()

let loginBT : UIButton = {
    let loginBT = UIButton()
    loginBT.backgroundColor = .systemBlue
    loginBT.setTitle("로그인", for: .normal)
    loginBT.layer.cornerRadius = 10
    loginBT.addTarget(self, action: #selector(tapLoginBT(_:)), for: .touchUpInside)
    return loginBT
}()
    
let signupBT : UIButton = {
    let signupBT = UIButton()
     signupBT.backgroundColor = .systemBlue
    signupBT.layer.cornerRadius = 10
    signupBT.setTitle("회원가입", for: .normal)
    signupBT.addTarget(self, action: #selector(tapSignUpBT(_:)), for: .touchUpInside)
        return signupBT
    }()
    
    
    
    
// MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstraints()
    
    }
    
    
// MARK: KeyBoard UP
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
        
    }
        
// MARK: @Objc
//   Login Button
    @objc func tapLoginBT(_ sender: UIButton) {
        Auth.auth().signIn(withEmail: idTextField.text!, password: passWordTextField.text!) { (user, error) in
            if user != nil {
                print("login Success")
                
                guard let user = user?.user else {return}
                self.firestore
                    .collection("User")
                    .document(user.uid)
                    .getDocument { (snapshot, error) in
                        if let error = error {
                            print(error.localizedDescription)
                        }else {
                            guard
                                let data = snapshot?.data(),
                            let email = data[UserReference.email] as? String,
                                let name = data[UserReference.name] as? String,
                                let balance = data[UserReference.balance] as? String
                                else {return}
                            
                            UserDefaults.standard.set(email, forKey: UserReference.email)
                            UserDefaults.standard.set(name, forKey: UserReference.name)
                            UserDefaults.standard.set(balance, forKey: UserReference.balance)
                            
                        }
                }
                self.dismiss(animated: true, completion: nil)
            }
            else{
                print("login fail")
            }
            self.idTextField.text = ""
            self.passWordTextField.text = ""
        }
    }
    
    
//    SignUp Button

    @objc func tapSignUpBT(_ sender: UIButton) {
        let signupVC = SignUpVC()
        navigationController?.pushViewController(signupVC, animated: true)
        navigationController?.modalPresentationStyle = .fullScreen
        
    }
    
    
    
 // MARK: SetUpConstraints
    
    private func setupConstraints() {
        //        let guide = view.safeAreaLayoutGuide
        
        [idTextField,passWordTextField,signupBT,loginBT].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            idTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200),
            idTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            idTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            passWordTextField.topAnchor.constraint(equalTo: idTextField.bottomAnchor, constant: 10),
            passWordTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            passWordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            loginBT.topAnchor.constraint(equalTo: passWordTextField.bottomAnchor, constant: 20),
            loginBT.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 100),
            loginBT.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            signupBT.topAnchor.constraint(equalTo: loginBT.bottomAnchor, constant: 10),
            signupBT.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 100),
            signupBT.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
  
        ])
    }
}
    
    


