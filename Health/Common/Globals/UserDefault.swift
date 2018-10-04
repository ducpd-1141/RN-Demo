//
//  UserDefault.swift
//  Eutopia
//
//  Created by vo.huu.dang.phong on 7/9/18.
//  Copyright © 2018 Gungnir. All rights reserved.
//

import Foundation

private struct Key {
    static let accessToken = "accessToken"
}

class UserDefault {

    private static let shared = UserDefaults.standard

    static var accessToken: String {
        set {
            UserDefault.shared.set(newValue, forKey: Key.accessToken)
            UserDefault.shared.synchronize()
        }
        get {
            return UserDefault.shared.string(forKey: Key.accessToken) ?? ""
        }
    }

    static func clearData() {
        UserDefault.shared.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        UserDefault.shared.synchronize()
    }
}
