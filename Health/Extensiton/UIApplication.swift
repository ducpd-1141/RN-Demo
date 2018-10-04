//
//  UIApplication.swift
//
//  Created by Dang Nguyen Vu on 8/3/17.
//  Copyright © 2017 Gungnir. All rights reserved.
//

import UIKit
/*
 Extension UIApplication
*/
extension UIApplication {
    /// Function TopViewController: get current dislay screen
    class func topViewController(_ base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(presented)
        }
        return base
    }
}
