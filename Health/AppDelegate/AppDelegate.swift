//
//  AppDelegate.swift
//  Health
//
//  Created by pham.dinh.duc on 10/1/18.
//  Copyright © 2018 Framgia. All rights reserved.
//

import UIKit
import RxSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private let bag = DisposeBag()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        setupRootViewController()
        return true
    }

    func setupRootViewController() {
        let navi = BaseNavigationController()
        let navigator = SplashNaigatorImplement(navigationController: navi)
        let vc = SplashViewController()
        vc.viewModel = SplashViewModel(navigator: navigator)
        navi.setViewControllers([vc], animated: false)
        window?.rootViewController = navi
    }
}

