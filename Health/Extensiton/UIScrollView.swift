//
//  UIScrollView.swift
//  airCloset
//
//  Created by Shohei Ohno on 2016/07/14.
//  Copyright © 2016年 Gungnir. All rights reserved.
//

import UIKit
import ObjectiveC

var actionBlockKey: UInt8 = 0
class ActionBlockWrapper {
    var block: (() -> Void)
    init(block: @escaping (() -> Void)) {
        self.block = block
    }
}

extension UIScrollView {

    func setRefreshControlOnView(_ callback: @escaping (() -> Void)) {
        objc_setAssociatedObject(self, &actionBlockKey, ActionBlockWrapper(block: callback), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        self.addSubview(refreshControl)
    }

    @objc func refresh() {
        guard let wrapper = objc_getAssociatedObject(self, &actionBlockKey) as? ActionBlockWrapper else { return }
        wrapper.block()
    }

    func stopLoading() {
        DispatchQueue.main.async {
            self.subviews.forEach {
                if $0 is UIRefreshControl {
                    ($0 as! UIRefreshControl).perform(#selector(($0 as! UIRefreshControl).endRefreshing), with: nil, afterDelay: 0)
                }
            }
        }
    }
}
