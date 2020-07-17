//
//  AddAccountVC.swift
//  Harusali
//
//  Created by Woobin Cheon on 2020/07/17.
//  Copyright © 2020 김믿음. All rights reserved.
//

import UIKit

class AddAccountVC: UIViewController {
    
    let addAccountView = AddAccountView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addAccountView.delegate = self
        setupUI()
        setupConstraint()

    }
    
    // MARK: - Setup UI
    func setupUI() {
        view.backgroundColor = .systemBackground
        
        addAccountView.backgroundColor = .lightGray
        
        view.addSubview(addAccountView)
    }
    
    // MARK: - Setup Constraint
    func setupConstraint() {
        let safeArea = view.safeAreaLayoutGuide
        
        addAccountView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            addAccountView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            addAccountView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            addAccountView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            addAccountView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -260)
        ])
    }
}

extension AddAccountVC: AddAccountViewDelegate {
    func dismissView() {
        guard let vc = presentingViewController as? AccountVC else {return}
        vc.dismiss(animated: true)
    }
    
//    func transferTextFieldContent(_ text: String) {
//        <#code#>
//    }
}

