//
//  SplashViewModel.swift
//  PhotoBeautyCleanArchitecture
//
//  Created by Duc Pham on 9/18/18.
//  Copyright © 2018 duc. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SplashViewModel: BaseViewModel, ViewModelType {
    private let navigator: SplashNavigator

    init(navigator: SplashNavigator) {
        self.navigator = navigator
    }

    func transform(input: Input) -> Output {
        let showAlbum = input.viewDidLoadTrigger.delay(2).do(onNext: { _ in
            self.navigator.toLogin()
        })
        return Output(drivers: [showAlbum])
    }
}

extension SplashViewModel {
    struct Input {
        let viewDidLoadTrigger: Driver<Void>
    }

    struct Output {
        let drivers: [Driver<Void>]
    }
}
