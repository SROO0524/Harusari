//
//  MainVC.swift
//  Harusali
//
//  Created by 김믿음 on 2020/07/14.
//  Copyright © 2020 김믿음. All rights reserved.
//
// 안녕

import UIKit
import Firebase

// MARK: Main화면

class MainVC: UIViewController {
    
   lazy var navController = UINavigationController(rootViewController: self.loginVC)
    let loginVC = ViewController()
    let label: UILabel = {
       let label = UILabel()
        label.text = "금액 정하는 화면"
        return label
    }()
    
    let button: UIButton = {
       let button = UIButton()
        button.setTitle("logout", for: .normal)
        button.addTarget(self, action: #selector(didTapLogout), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
        label.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        
        view.addSubview(button)
        button.frame = CGRect(x: 200, y: 200, width: 200, height: 200)
        view.backgroundColor = .red
        
        
        checkIfUserLoggedIn()
    }
// MARK: LogOut/ Logout 되면 로그인 TextField reset
    @objc func didTapLogout() {
        let loginVC = ViewController()
        try? Auth.auth().signOut()
        navigationController?.navigationBar.topItem?.title = "로그인"
        navigationController?.navigationBar.prefersLargeTitles = true
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true)

        
    }
// MARK: 로그인이 되어 있으면 Main 화면 / 로그인 안되어 있음 로그인 화면 나타남
    func checkIfUserLoggedIn() {
        if Auth.auth().currentUser == nil {
            print("ZZZZZ")
            DispatchQueue.main.async {
                //navController.navigationItem.title = "Login"은 왜 안되었즤..?
                self.navController.navigationBar.topItem?.title = "로그인"
                self.navController.navigationBar.prefersLargeTitles = true
                self.navController.modalPresentationStyle = .fullScreen
                self.present(self.navController, animated: true)
            }
            return
        } else {
            print("aaa")
        }
    }
    
}
