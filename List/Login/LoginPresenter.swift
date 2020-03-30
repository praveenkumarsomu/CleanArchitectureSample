//
//  LoginPresenter.swift
//  List
//
//  Created by Praveenkumar Somu on 30/3/2563 BE.
//  Copyright © 2563 Praveenkumar Somu. All rights reserved.
//

import Foundation
import UIKit

class LoginPresenter: ViewToPresenterProtocol, InteractorToPresenterProtocol {
    var view: ViewController?
    var interactor: PresenterToInteractorProtocol?
    var router: PresenterToRouterProtocol?
    func setupInitialStateUI() {
        view?.userNameTextField.delegate = view as? UITextFieldDelegate
        view?.passwordTextField.delegate = view as? UITextFieldDelegate
        view?.signinButton.isEnabled = false
        if interactor?.isExistingUser() ?? false {
            view?.passwordTextField.text = interactor?.user?.email
            view?.userNameTextField.text = interactor?.user?.password
            view?.signinButton.isEnabled = true
        }
        validateEmailAndPasswordFields()
    }
    func validateEmailAndPasswordFields() {
        guard let view = view, let interactor = interactor else {return}
        let validemail = view.userNameTextField.reactive.continuousTextValues.map { text in
            return text.isValidEmail()
        }
        let password = view.passwordTextField.reactive.continuousTextValues.map { text in
            return interactor.validatePassword(password: text)
        }
        let validation = validemail.combineLatest(with: password)
        validation.observeValues { (validation) in
            view.signinButton.isEnabled = validation.0 && validation.1
        }
    }
    func routeToDashBoardView() {
        interactor?.saveUserNameAndPassword(username: view?.userNameTextField.text, password: view?.passwordTextField.text)
        router?.routeToDashBoardView()
    }
}

