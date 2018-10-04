//
//  LocalError.swift
//  Eutopia
//
//  Created by le.thanh.quang on 7/10/18.
//  Copyright © 2018 Framgia. All rights reserved.
//

import Foundation

enum LocalError: Error, LocalizedError {
    case error(message: String?)

    public var errorDescription: String? {
        switch self {
        case .error(let message):
            return message ?? "API_PARSER_ERROR".localized
        }
    }
}
