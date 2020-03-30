//
//  LoginViewModel.swift
//  List
//
//  Created by Praveenkumar Somu on 27/3/2563 BE.
//  Copyright © 2563 Praveenkumar Somu. All rights reserved.
//

import Foundation
import ReactiveSwift

class LoginViewModel {
    var user: User?
    @UserDefaultsRepo(key: "email")
    var email: String?
    @UserDefaultsRepo(key: "password")
    var password: String?
    
    func validatePassword(password: String) -> Bool {
        return password.count >= 8
    }
    
    func isExistingUser() -> Bool {
        return !(email?.isEmpty ?? true) && !(password?.isEmpty ?? true)
    }
}
