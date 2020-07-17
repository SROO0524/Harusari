//
//  LoginVC.swift
//  Harusali
//
//  Created by 김믿음 on 2020/07/12.
//  Copyright © 2020 김믿음. All rights reserved.
//

import UIKit
import Firebase
import Lottie


// MARK: Login ViewController

class SignInVC: UIViewController {

    
// MARK: Property

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
    
let loginLabal : UILabel = {
    let loginLabal = UILabel()
    loginLabal.backgroundColor = .systemBlue
    loginLabal.text = "로그인"
    loginLabal.layer.cornerRadius = 10
    return loginLabal
    }()
    
    
let signupBT : UIButton = {
    let signupBT = UIButton()
     signupBT.backgroundColor = .systemBlue
    signupBT.layer.cornerRadius = 10
    signupBT.setTitle("회원가입", for: .normal)
    signupBT.addTarget(self, action: #selector(tapSignUpBT(_:)), for: .touchUpInside)
        return signupBT
    }()
    
 let animationView : AnimationView = {
    let animationView = AnimationView(name: "lf30_editor_alHpIE")
    animationView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
    animationView.contentMode = .scaleAspectFit
    animationView.loopMode = .playOnce
    animationView.animationSpeed = 0.5
     return animationView
 }()
    
    
// MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(animationView)
        animationView.center = view.center
        
       // 애니메이션 실행
        animationView.play{ (finish) in
            print("애니메이션 끝")
            self.view.backgroundColor = .white
            self.animationView.removeFromSuperview()
            self.setupConstraints()
        
            }
    }
    
    
// MARK: KeyBoard Up
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
        
    }
        
// MARK: @Objc
//   Login Button
    @objc func tapLoginBT(_ sender: UIButton) {
        Auth.auth().signIn(withEmail: idTextField.text!, password: passWordTextField.text!) { (user, error) in
            if user != nil {
                print("login Success")
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
    
    


