//
//  LoginViewModel.swift
//  Health
//
//  Created by pham.dinh.duc on 10/1/18.
//  Copyright © 2018 Framgia. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class LoginViewModel: BaseViewModel, ViewModelType {
    private let navigator: LoginNavigator

    init(_ navigator: LoginNavigator) {
        self.navigator = navigator
    }

    func transform(input: Input) -> Output {
        let toTop = input.viewDidLoadTrigger.delay(2).do(onNext: { _ in
            self.navigator.toTop()
        })
        return Output(drivers: [toTop])
    }
}

extension LoginViewModel {
    struct Input {
        let viewDidLoadTrigger: Driver<Void>
    }

    struct Output {
        let drivers: [Driver<Void>]
    }
}
