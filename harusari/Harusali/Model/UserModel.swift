//
// UserModel.swift
//  Harusali
//
//  Created by 김믿음 on 2020/07/16.
//  Copyright © 2020 김믿음. All rights reserved.
//

import Foundation

struct UserModel {
    let email: String
    let name: String
    let balance : Int
}

struct UserReference {
    static let email = "Email"
    static let name = "Name"
    static let balance = "Balance"
}
