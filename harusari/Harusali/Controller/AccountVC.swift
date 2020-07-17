//
//  AccountViewController.swift
//  harusari-woobin
//
//  Created by Woobin Cheon on 2020/07/16.
//  Copyright © 2020 Woobin Cheon. All rights reserved.
//

import UIKit

class AccountVC: UIViewController {

    let accountView = AccountView()
    
    let navibarRButton = UIBarButtonItem(image: UIImage(systemName: "house"), style: .done, target: self, action: #selector(navibarRButtonAction(_:)))
    
    let navibarLButton = UIBarButtonItem(image: UIImage(systemName: "house"), style: .done, target: self, action: #selector(navibarLButtonAction(_:)))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        accountView.delegate = self
        setupUI()
        setupConstraint()
    }
    
    @objc func navibarRButtonAction(_ sender: UIBarButtonItem) {
        // do something
    }
    
    @objc func navibarLButtonAction(_ sender: UIBarButtonItem) {
        // do something
    }
    
    func setupUI() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "가계부 화면"
        navigationItem.rightBarButtonItem = navibarRButton
        navigationItem.leftBarButtonItem = navibarLButton
    }
    
    func setupConstraint() {
        view.addSubview(accountView)
        
        let safeArea = view.safeAreaLayoutGuide
        
        accountView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            accountView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            accountView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            accountView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            accountView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
        
        
    }
    

}
extension AccountVC: PresentDelegate {
    func presentView() {
        let vc = AddAccountVC()
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
    }
}
