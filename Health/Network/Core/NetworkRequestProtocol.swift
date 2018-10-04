//
//  NetworkRequestProtocol.swift
//  Health
//
//  Created by pham.dinh.duc on 10/1/18.
//  Copyright © 2018 Framgia. All rights reserved.
//

import Foundation
import Alamofire

protocol NetworkRequestProtocol {
    var method: HTTPMethod { get }
    var path: String { get }
    var header: Parameters? { get }
    var params: Parameters? { get }
    var body: Parameters? { get }
    var createURLRequest: URLRequest { get }
}

extension NetworkRequestProtocol {
    var defaultHeader: Parameters {
        return ["Content-Type": "application/json"]
    }

    var createURLRequest: URLRequest {
        let url = URL(string: NetworkConfiguration.endPoint)
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = method.rawValue
        urlRequest.setHeaders(defaultHeader)
        urlRequest.setHeaders(header)
        urlRequest.setParams(params)
        urlRequest.setBody(body)
        if !UserDefault.accessToken.isEmpty {
            urlRequest.setValue("Bearer \(UserDefault.accessToken)", forHTTPHeaderField: "Authorization")
        }
        return urlRequest
    }
}

