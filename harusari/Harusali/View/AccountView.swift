//
//  AccountView.swift
//  harusari-woobin
//
//  Created by Woobin Cheon on 2020/07/16.
//  Copyright © 2020 Woobin Cheon. All rights reserved.
//

import UIKit

class AccountView: UIView {
    
    let tempViewForCallender = UIView()
    let moneyLabel = UILabel()
    let tempViewForTable = UIView()
    let scrollView = UIScrollView()
    let addButton = UIButton()
    
    struct addButtonSize {
        static let width: CGFloat = 50
        static let height: CGFloat = 50
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

    
    func setupUI() {
        tempViewForCallender.backgroundColor = .systemTeal
        
        moneyLabel.backgroundColor = .systemPink
        moneyLabel.layer.cornerRadius = moneyLabel.frame.width / 2
        moneyLabel.font = .preferredFont(forTextStyle: .largeTitle)
        moneyLabel.textColor = .white
        moneyLabel.text = "₩ 100,000"
        
        tempViewForTable.backgroundColor = .systemYellow
        
        addButton.backgroundColor = .systemGreen
        
        addButton.frame = CGRect(x: tempViewForTable.frame.size.height - addButtonSize.height, y: tempViewForTable.frame.size.width - addButtonSize.width, width: addButtonSize.width, height: addButtonSize.height)
        self.addSubview(addButton)
    }
    
    func setupConstraint() {
        [moneyLabel, tempViewForCallender, tempViewForTable].forEach({
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            
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
            tempViewForTable.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            
        ])
    }
}
