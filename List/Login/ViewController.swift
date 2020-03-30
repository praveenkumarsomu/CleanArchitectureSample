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

class ViewController: UIViewController, PresenterToViewProtocol {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signinButton: UIButton!
    var viewModel: LoginViewModel!
    var presenter: ViewToPresenterProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        container.register(LoginViewModel.self) { (resolver) in
            return LoginViewModel()
        }
        viewModel = container.resolve(LoginViewModel.self)
        presenter?.setupInitialStateUI()
    }

    @IBAction func signInAction(_ sender: UIButton) {
        presenter?.routeToDashBoardView()
    }
    func routeToDashBoardView() {
        let dashboardVC = storyboard?.instantiateViewController(identifier: "DashboardViewController") as! DashboardViewController
        container.register(DashboardViewModel.self) { (resolver) in
            let dashboardViewModel = DashboardViewModel()
            dashboardViewModel.dataSource = Array(1...1000)
            return dashboardViewModel
        }
        self.navigationController?.pushViewController(dashboardVC, animated: true)
    }
}

