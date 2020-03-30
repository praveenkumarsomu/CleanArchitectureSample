//
//  LoginRouter.swift
//  List
//
//  Created by Praveenkumar Somu on 30/3/2563 BE.
//  Copyright © 2563 Praveenkumar Somu. All rights reserved.
//

import Foundation
import UIKit

class LoginRouter: PresenterToRouterProtocol {
    func routeToDashBoardView() {
        
    }
    static func createListModule() -> ViewController {
        let view = LoginRouter.storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        var presenter: ViewToPresenterProtocol & InteractorToPresenterProtocol = LoginPresenter()
        var interactor: PresenterToInteractorProtocol = LoginInteractor()
        let router:PresenterToRouterProtocol = LoginRouter()
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        return view
    }
    static var storyboard: UIStoryboard {
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
}
