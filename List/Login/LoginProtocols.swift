//
//  LoginProtocols.swift
//  List
//
//  Created by Praveenkumar Somu on 30/3/2563 BE.
//  Copyright © 2563 Praveenkumar Somu. All rights reserved.
//

import Foundation

protocol ViewToPresenterProtocol {
    var view: ViewController? {get set}
    var router: PresenterToRouterProtocol? {get set}
    func setupInitialStateUI()
    func validateEmailAndPasswordFields()
    func routeToDashBoardView()
}
protocol PresenterToViewProtocol {
    
}
protocol PresenterToInteractorProtocol {
    var presenter: InteractorToPresenterProtocol? {get set}
    func isExistingUser() -> Bool
    func validatePassword(password: String) -> Bool
    func saveUserNameAndPassword(username: String?, password: String?)
    var user: User? {get}
}
protocol InteractorToPresenterProtocol {
    var interactor: PresenterToInteractorProtocol? {get set}
}
protocol PresenterToRouterProtocol {
    func routeToDashBoardView()
}
