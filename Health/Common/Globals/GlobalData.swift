//
//  GlobalData.swift
//  Eutopia
//
//  Created by vo.huu.dang.phong on 7/9/18.
//  Copyright © 2018 Gungnir. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

/// Use for cache variables in-memory when application launching. Ex: API result, ...
class GlobalData {
    static var shared = GlobalData()
}
