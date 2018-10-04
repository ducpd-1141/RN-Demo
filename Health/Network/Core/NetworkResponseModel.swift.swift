//
//  NetworkResponseModel.swift
//  Eutopia
//
//  Created by le.thanh.quang on 7/10/18.
//  Copyright © 2018 Gungnir. All rights reserved.
//

import Foundation
import ObjectMapper

struct NetworkResponseModel {
    var data: [String: Any]?
    var errorCode: String?
    var errorMessage: String?
}

extension NetworkResponseModel: Mappable {
    init?(map: Map) {
    }

    mutating func mapping(map: Map) {
        data <- map["data"]
        errorCode <- map["error_code"]
        errorMessage <- map["error_message"]
    }
}
