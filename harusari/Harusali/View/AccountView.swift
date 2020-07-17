//
//  AccountView.swift
//  harusari-woobin
//
//  Created by Woobin Cheon on 2020/07/16.
//  Copyright © 2020 Woobin Cheon. All rights reserved.
//

import UIKit

protocol PresentDelegate: class {
    func presentView()
}

class AccountView: UIView {
    
    let tempViewForCallender = UIView()
    let moneyLabel = UILabel()
    let tempViewForTable = UIView()
    let scrollView = UIScrollView()
    let addButton = UIButton()
    
    weak var delegate: PresentDelegate?
    
    struct addButtonSize {
        static let widthHeight: CGFloat = 70
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: - Setup UI
    func setupUI() {
        tempViewForCallender.backgroundColor = .systemTeal
        
        moneyLabel.backgroundColor = .systemPink
        moneyLabel.layer.cornerRadius = moneyLabel.frame.width / 2
        moneyLabel.font = .preferredFont(forTextStyle: .largeTitle)
        moneyLabel.textColor = .white
        moneyLabel.text = "₩ 100,000"
        
        tempViewForTable.backgroundColor = .systemYellow
        
        addButton.backgroundColor = .systemGreen
        addButton.layer.cornerRadius = addButtonSize.widthHeight / 2
        addButton.setImage(UIImage(systemName: "plus"), for: .normal)
        addButton.addTarget(self, action: #selector(addAccountList(_:)), for: .touchUpInside)
    }
    
    // MARK: - Setup Constraint
    func setupConstraint() {
        [moneyLabel, tempViewForCallender, tempViewForTable, addButton].forEach({
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        })
        
        [moneyLabel, tempViewForCallender, tempViewForTable].forEach({
            NSLayoutConstraint.activate([
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            $0.trailingAnchor.constraint(equalTo: self.trailingAnchor)])
        })
        
        NSLayoutConstraint.activate([
            tempViewForCallender.topAnchor.constraint(equalTo: self.topAnchor),
            tempViewForCallender.heightAnchor.constraint(equalToConstant: 50),
            
            moneyLabel.topAnchor.constraint(equalTo: tempViewForCallender.bottomAnchor),
            moneyLabel.heightAnchor.constraint(equalToConstant: 50),
            
            tempViewForTable.topAnchor.constraint(equalTo: moneyLabel.bottomAnchor),
            tempViewForTable.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            addButton.widthAnchor.constraint(equalToConstant: addButtonSize.widthHeight),
            addButton.heightAnchor.constraint(equalToConstant: addButtonSize.widthHeight),
            addButton.trailingAnchor.constraint(equalTo: tempViewForTable.trailingAnchor, constant: -20),
            addButton.bottomAnchor.constraint(equalTo: tempViewForTable.bottomAnchor, constant: -20)
        ])
    }
    
    // MARK: - Selector
    @objc func addAccountList(_ sender: UIButton) {
        // present add Account VC delegate
        delegate?.presentView()
    }
}
