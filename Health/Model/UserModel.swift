//
//  UserModel.swift
//  Eutopia
//
//  Created by pham.dinh.duc on 1/10/18.
//  Copyright © 2018 Framgia. All rights reserved.
//

import Foundation
import ObjectMapper

struct UserModel {
    var id: Int?
    var username: String?
    var image: String?
}

extension UserModel: Mappable {

    init?(map: Map) {
    }

    mutating func mapping(map: Map) {
        id <- map["id"]
        username <- map["username"]
    }
}
