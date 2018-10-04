//
//  TopNavigator.swift
//  Health
//
//  Created by pham.dinh.duc on 10/1/18.
//  Copyright © 2018 Framgia. All rights reserved.
//

import UIKit

protocol TopNavigator {
    func toHealthLinkage()
}

class TopNaigatorImplement: TopNavigator {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func toHealthLinkage() {
    }
}
