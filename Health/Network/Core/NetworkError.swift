//
//  NetworkError.swift
//  Eutopia
//
//  Created by dang.nguyen.vu on 7/3/18.
//  Copyright © 2018 Framgia. All rights reserved.
//

import Foundation
import ObjectMapper

enum NetworkError: Error, LocalizedError {
    // TODOs: Add Case
    case parserJsonError
    case unauthorized
    case unauthenticated
    case networkError
    case apiFailure(code: String?, message: String)
    case encodingFail
    case timeout
    case expiredToken

    public var value: String {
        return String(describing: self)
    }

    public var errorDescription: String? {
        // TODOs: Keep update this with new API
        // TODOs: Add those error message foreach case to Localization files
        switch self {
        case .apiFailure(let errorCode, let message):
            print("ERROR WITH API ERROR CODE: \(String(describing: errorCode))")
            return message.isWhiteSpaceOrEmpty() ? "API_PARSER_ERROR".localized : message
        case .networkError:
            return "API_SERVER_CONNECT_FAIL_ERROR".localized
        case .unauthorized, .unauthenticated:
            return nil
        case .parserJsonError:
            return "API_PARSER_ERROR".localized
        case .encodingFail:
            return "API_PARSER_ERROR".localized
        case .timeout:
            return "API_SERVER_CONNECT_FAIL_ERROR".localized
        case .expiredToken:
            return "API_EXPIRED_TOKEN_ERROR".localized
        }
    }
}
extension NetworkError: Equatable {
    public static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        return lhs.value == rhs.value
    }
}
