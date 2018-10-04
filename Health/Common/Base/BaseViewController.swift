//
//  BaseViewController.swift
//  PB
//
//  Created by pham.dinh.duc on 5/3/18.
//  Copyright © 2018 pham.dinh.duc. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class BaseViewController: UIViewController {
    var bag = DisposeBag()

    override func viewDidLoad() {
        setupUI()
        setupData()
    }

    internal func setupUI() { }
    internal func setupData() { }
}
