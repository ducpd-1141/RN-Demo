//
//  ConstantManager.swift
//  Eutopia
//
//  Created by le.thanh.quang on 7/10/18.
//  Copyright © 2018 Gungnir. All rights reserved.
//

import Foundation
import SwiftDate

struct NumberConstant {
    static let buttonDelay: TimeInterval = 0.3
    static let apiPagerMaxItems = 16
}

struct StringConstant {
    static let originalImageKey = "original"
    static let didReceivePushNotification = NSNotification.Name("didReceivePushNotification")
    static let homeDidChangeScreenNotification = NSNotification.Name("homeDidChangeScreenNotification")
    static let homeWillChangeScreenNotification = NSNotification.Name("homeWillChangeScreenNotification")
    static let homeEnableSwipeToChangeScreenNotification = NSNotification.Name("homeEnableSwipeToChangeScreenNotification")
    static let blockUserMainScreenNotification = NSNotification.Name("blockUserMainScreenNotification")
    static let unblockUserMainScreenNotification = NSNotification.Name("unblockUserMainScreenNotification")
    static let blockArtMainScreenNotification = NSNotification.Name("blockArtMainScreenNotification")
    static let deleteSeedMainScreenNotification = NSNotification.Name("deleteSeedMainScreenNotification")
    static let stopBackgroundVideoNotification = NSNotification.Name("stopBackgroundVideoNotification")
    static let appResumedNotification = NSNotification.Name("appResumedNotification")
    static let appStoreURLString = "http://itunes.apple.com/jp/app/id1390442483"
}

struct DateFormatsConstant {
    static let seedDisplayDateTime: DateToStringStyles = .custom("yyyy.MM.dd HH:mm")
}
