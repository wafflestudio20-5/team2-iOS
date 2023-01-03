//
//  LoginModel.swift
//  jisikin-ios
//
//  Created by Chaehyun Park on 2023/01/01.
//

struct Login {
    var ID: String
    var password: String
}

struct SignUp: Encodable {
    var isMale: Bool
    var password: String
    var uid: String
    var username: String
}
