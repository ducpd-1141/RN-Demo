//
//  TopViewModel.swift
//  Health
//
//  Created by pham.dinh.duc on 10/1/18.
//  Copyright © 2018 Framgia. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class TopViewModel: BaseViewModel, ViewModelType {
    private let navigator: TopNavigator

    init(_ navigator: TopNavigator) {
        self.navigator = navigator
    }

    func transform(input: Input) -> Output {
        let toTop = input.viewDidLoadTrigger.delay(2).do(onNext: { _ in
            self.navigator.toHealthLinkage()
        })
        return Output(drivers: [toTop])
    }
}

extension TopViewModel {
    struct Input {
        let viewDidLoadTrigger: Driver<Void>
    }

    struct Output {
        let drivers: [Driver<Void>]
    }
}


