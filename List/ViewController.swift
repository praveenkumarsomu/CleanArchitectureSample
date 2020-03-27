//
//  ViewController.swift
//  List
//
//  Created by Praveenkumar Somu on 27/3/2563 BE.
//  Copyright © 2563 Praveenkumar Somu. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
import Swinject

class ViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signinButton: UIButton!
    var viewModel: LoginViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        container.register(LoginViewModel.self) { (resolver) in
            return LoginViewModel()
        }
        viewModel = container.resolve(LoginViewModel.self)
        setupUI()
    }
    func setupUI() {
        userNameTextField.delegate = self
        userNameTextField.keyboardType = .emailAddress
        passwordTextField.delegate = self
        signinButton.isEnabled = false
        if viewModel.isExistingUser() {
            passwordTextField.text = viewModel.password
            userNameTextField.text = viewModel.email
            signinButton.isEnabled = true
        }
        validateEmailAndPasswordFields()
    }
    func validateEmailAndPasswordFields() {
        let validemail = userNameTextField.reactive.continuousTextValues.map { text in
            return text.isValidEmail()
        }
        let password = passwordTextField.reactive.continuousTextValues.map { text in
            return self.viewModel.validatePassword(password: text)
        }
        let validation = validemail.combineLatest(with: password)
        validation.observeValues { (validation) in
            self.signinButton.isEnabled = validation.0 && validation.1
        }
    }

    @IBAction func signInAction(_ sender: UIButton) {
        let alertController = UIAlertController(title: "", message: "Welcome back", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: {
            self.viewModel.email = self.userNameTextField.text
            self.viewModel.password = self.passwordTextField.text
        })
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
