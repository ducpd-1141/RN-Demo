//
//  Network.swift
//  Eutopia
//
//  Created by dang.nguyen.vu on 7/4/18.
//  Copyright © 2018 Framgia. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import RxSwift
import RxCocoa
import RxAlamofire

class Network {
    private static var configuration: URLSessionConfiguration {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30
        config.timeoutIntervalForResource = 30
        return config
    }

    private static var uploadConfiguration: URLSessionConfiguration {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30
        config.timeoutIntervalForResource = 30
        return config
    }

    private static var sessionManager = SessionManager(configuration: configuration)

    private static var updateSessionManager = SessionManager(configuration: uploadConfiguration)

    /// This will call the request to endpoint.
    ///
    /// - Parameter request: URLRequestConvertible which contain information about the request
    /// - Returns: the data [String: Any] on the key "data" will return when meet those conditions:
    ///             - valid statusCode
    class func request(_ request: URLRequestConvertible) -> Observable<[String: Any]> {
        return sessionManager.rx.request(urlRequest: request)
            .responseJSON()
            .flatMap({ (responseJSON) -> Observable<[String: Any]> in
                guard let response = responseJSON.response,
                    let data = responseJSON.result.value else {
                        return Observable.error(NetworkError.parserJsonError)
                }
                // Validate status code
                if response.statusCode >= 200 && response.statusCode < 300 {
                    // Validate date
                    guard let json = data as? [String: Any],
                        let baseResponse = Mapper<NetworkResponseModel>().map(JSON: json) else {
                            return Observable.error(NetworkError.parserJsonError)
                    }
                    return Observable.just(baseResponse.data ?? [:])
                } else {
                    return Observable.error(handleRejectRequest(response.statusCode, data))
                }
            }).catchError({ (error) -> Observable<[String: Any]> in
                // use catchError to handle URLError.Code.notConnectedToInternet case
                if let apiError = error as? NetworkError {
                    return Observable.error(apiError)
                } else if (error as NSError).code == -1001 {
                    return Observable.error(NetworkError.timeout)
                } else {
                    return Observable.error(NetworkError.networkError)
                }
            })
    }

    static func generalNewFileName(extendName: String? = "png") -> String {
        return String(format: "%5.0f.%@", arguments: [Date().timeIntervalSince1970, extendName ?? "png"])
    }
}

// MARK: - Handle API Error
extension Network {
    /// Handle the reject request from server with HTTPStatusCode
    ///
    /// - HTTPStatusCode 400 is an invalid request
    ///
    /// - HTTPStatusCode 401, 403 are APIError.unauthenticated and APIError.unauthorized
    ///
    /// - HTTPStatusCode 500 is something when wrong on server
    ///
    /// - Parameters:
    ///   - statusCode: HTTP StatusCode
    ///   - data: raw data response
    /// - Returns: APIError parsered
    private class func handleRejectRequest(_ statusCode: Int, _ data: Any) -> NetworkError {
        // NOTICE: This function is not statable, it will be edit during development time with matched case with API
        let error = parserAPIError(data)
        switch statusCode {
        case 401:
            return error.apiError
        case 400, 403:
            // TODOs: handle APIError.unauthorized case
            return error.apiError
        default:
            return NetworkError.networkError
        }
    }

    private class func parserAPIError(_ data: Any) -> (apiError: NetworkError, responseModel: NetworkResponseModel?) {
        guard let errorJson = data as? [String: Any],
            let errorModel = Mapper<NetworkResponseModel>().map(JSON: errorJson) else {
                return (NetworkError.parserJsonError, nil)
        }
        guard let apiErrorMessage = errorModel.errorMessage else {
            return (NetworkError.parserJsonError, nil)
        }
        let apiError = NetworkError.apiFailure(code: errorModel.errorCode, message: apiErrorMessage)
        return (apiError, errorModel)
    }
}
