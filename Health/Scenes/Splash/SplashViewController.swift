//
//  SplashViewController.swift
//  Health
//
//  Created by pham.dinh.duc on 9/18/18.
//  Copyright © 2018 Framgia. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class SplashViewController: BaseViewController {
    var viewModel: SplashViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func setupUI() {

    }

    override func setupData() {
        let input = SplashViewModel.Input(viewDidLoadTrigger: Driver<Void>.just(Void()))
        let output = viewModel.transform(input: input)
        output.drivers.forEach { $0.drive().disposed(by: bag) }
    }
}
