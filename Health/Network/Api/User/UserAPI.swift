//
//  UserAPI.swift
//  Health
//
//  Created by pham.dinh.duc on 10/1/18.
//  Copyright © 2018 Framgia. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import ObjectMapper
import Alamofire

private struct Constants {
    struct APIKey {
        static let email = "email"
        static let password = "password"
    }
}

enum UserAPI: URLRequestConvertible, NetworkRequestProtocol {
    case login(email: String, password: String)

    var method: HTTPMethod {
        return .post
    }

    var path: String {
        switch self {
        case .login:
            return "/user"
        }
    }

    var header: Parameters? {
        return nil
    }

    var params: Parameters? {
        return nil
    }

    var body: Parameters? {
        switch self {
        case .login(let email, let password):
            return [Constants.APIKey.email: email, Constants.APIKey.password: password]
        }
    }

    func asURLRequest() throws -> URLRequest {
        return self.createURLRequest
    }
}


extension Network {
    class func login(email: String, password: String) -> Observable<Void> {
        let request = UserAPI.login(email: email, password: password)
        return Network.request(request)
            .flatMap { (json) -> Observable<Void> in
                return Observable.just(())
        }
    }
}
