//
//  SplashNavigator.swift
//  PhotoBeautyCleanArchitecture
//
//  Created by Duc Pham on 9/18/18.
//  Copyright © 2018 duc. All rights reserved.
//

import UIKit

protocol SplashNavigator {
    func toLogin()
}

class SplashNaigatorImplement: SplashNavigator {

    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func toLogin() {
        let vc = LoginViewController()
        let navigator = LoginNaigatorImplement(navigationController: navigationController)
        vc.viewModel = LoginViewModel(navigator)
        navigationController.pushViewController(vc, animated: true)
    }
}
