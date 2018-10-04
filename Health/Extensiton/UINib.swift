//
//  UINib.swift
//  airCloset
//
//  Created by Shohei Ohno on 2016/01/14.
//  Copyright © 2016年 Gungnir. All rights reserved.
//

import UIKit

extension UINib {
    class func instantiateFromNib<T: UIView, U: Any>(_: T.Type, owner: U, nibName: String? = nil) -> T where T: NSObject {
        let bundle = Bundle(for: type(of: owner) as! AnyClass)
        let name = nibName ?? T.className
        return UINib(nibName: name, bundle: bundle).instantiate(withOwner: owner, options: nil).first as! T
    }
}
