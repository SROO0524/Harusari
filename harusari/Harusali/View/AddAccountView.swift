//
//  AddAccountView.swift
//  Harusali
//
//  Created by Woobin Cheon on 2020/07/17.
//  Copyright © 2020 김믿음. All rights reserved.
//

import UIKit

protocol AddAccountViewDelegate: class {
    func dismissView()
//    func transferTextFieldContent(_ text: String)
}

class AddAccountView: UIView {
    
    let cancelButton = UIButton()
    let titleLabel = UILabel()
    let confirmButton = UIButton()
    let dividerView = UIView()
    let moneyTextField = UITextField()
    let monetaryUnitLabel = UILabel()
     let numberFormatter = NumberFormatter()
    
    weak var delegate: AddAccountViewDelegate?
   

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
        cancelButton.backgroundColor = .systemBlue
        cancelButton.setTitle("취소", for: .normal)
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        cancelButton.addTarget(self, action: #selector(cancelButtonAction(_:)), for: .touchUpInside)
        
        titleLabel.backgroundColor = .systemRed
        titleLabel.text = "내역 추가"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        
        confirmButton.backgroundColor = .systemBlue
        confirmButton.setTitle("확인", for: .normal)
        confirmButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        confirmButton.addTarget(self, action: #selector(confirmButtonAction(_:)), for: .touchUpInside)
        
        dividerView.backgroundColor = .green
        
        moneyTextField.delegate = self
        moneyTextField.keyboardType = .numberPad
        moneyTextField.backgroundColor = .systemTeal
        moneyTextField.textAlignment = .right
        moneyTextField.font = UIFont.systemFont(ofSize: 44)
        
        numberFormatter.numberStyle = .decimal
        numberFormatter.locale = Locale.current
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = 3
        
        monetaryUnitLabel.backgroundColor = .systemOrange
        monetaryUnitLabel.text = "₩"
        monetaryUnitLabel.textAlignment = .center
        monetaryUnitLabel.font = UIFont.systemFont(ofSize: 44)
    }
    
    // MARK: - Setup Constraint
    func setupConstraint() {
        [cancelButton, titleLabel, confirmButton, dividerView, monetaryUnitLabel, moneyTextField].forEach({
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        })
        
        [cancelButton, titleLabel, confirmButton].forEach({
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: self.topAnchor),
                $0.bottomAnchor.constraint(equalTo: dividerView.topAnchor)
            ])
        })
        
        NSLayoutConstraint.activate([
            cancelButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            cancelButton.trailingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.widthAnchor.constraint(equalToConstant: 250),
            
            confirmButton.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            confirmButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            dividerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0),
            dividerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            dividerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            dividerView.widthAnchor.constraint(equalToConstant: 1),
            
            monetaryUnitLabel.topAnchor.constraint(equalTo: dividerView.bottomAnchor, constant: 40),
            monetaryUnitLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            monetaryUnitLabel.widthAnchor.constraint(equalToConstant: 60),
            monetaryUnitLabel.heightAnchor.constraint(equalToConstant: 60),
            
            moneyTextField.topAnchor.constraint(equalTo: dividerView.bottomAnchor, constant: 40),
            moneyTextField.leadingAnchor.constraint(equalTo: monetaryUnitLabel.trailingAnchor, constant: 0),
            moneyTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            moneyTextField.heightAnchor.constraint(equalToConstant: 60),
        ])
        
        
    }
    
    // MARK: - Selector
    @objc func cancelButtonAction(_ sender: UIButton) {
        delegate?.dismissView()
    }
    
    @objc func confirmButtonAction(_ sender: UIButton) {
        //
    }
}

extension AddAccountView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let removeAllSeparator = textField.text?.replacingOccurrences(of: numberFormatter.groupingSeparator, with: "") {
            print(removeAllSeparator)
            var beforeFormattedString = removeAllSeparator + string
            if numberFormatter.number(from: string) != nil {
                if let formattedNumber = numberFormatter.number(from: beforeFormattedString),
                    let formattedString = numberFormatter.string(from: formattedNumber) {
                    textField.text = formattedString
                    return false
                }
            } else {
                if string == "" {
                    let lastIndex = beforeFormattedString.index(beforeFormattedString.endIndex, offsetBy: -1)
                    beforeFormattedString = String(beforeFormattedString[..<lastIndex])
                    if let formattedNumber = numberFormatter.number(from: beforeFormattedString),
                        let formattedString = numberFormatter.string(from: formattedNumber) {
                        textField.text = formattedString
                        return false
                    }
                } else {
                    return false
                }
            }
        }
        return true
    }
}
