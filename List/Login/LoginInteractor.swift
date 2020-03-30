//
//  LoginInteractor.swift
//  List
//
//  Created by Praveenkumar Somu on 30/3/2563 BE.
//  Copyright © 2563 Praveenkumar Somu. All rights reserved.
//

import Foundation

class LoginInteractor: PresenterToInteractorProtocol {    
    @UserDefaultsRepo(key: "email")
    var email: String?
    @UserDefaultsRepo(key: "password")
    var password: String?
    var presenter: InteractorToPresenterProtocol?
    var user: User? {
        get {
            User(email: email, password: password)
        }
    }
    func saveUserNameAndPassword(username: String?, password: String?) {
        self.email = username
        self.password = password
    }
    func isExistingUser() -> Bool {
        return !(user?.email?.isEmpty ?? true) && !(user?.password?.isEmpty ?? true)
    }
    
    func validatePassword(password: String) -> Bool {
        password.count > 8
    }
}
