//
//  User.swift
//  sleep-only-with-hand
//
//  Created by 이창현 on 2018. 8. 18..
//  Copyright © 2018년 이창현. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

struct User {
    var id:String
    var password:String
    var name:String
    var gender:String
}

var currentUser:User?

extension User {
//    static func userTransform(temp:JSON) -> User {
//        //let user = User(id: id, password: temp["password"].stringValue, name: temp["username"].stringValue, gender: temp["email"].stringValue)
//        
//        return User
//    }
}
