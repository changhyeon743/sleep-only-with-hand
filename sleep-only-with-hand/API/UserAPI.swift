//
//  UserAPI.swift
//  sleep-only-with-hand
//
//  Created by 이창현 on 2018. 8. 18..
//  Copyright © 2018년 이창현. All rights reserved.
//

import Foundation
import Alamofire
import UIKit
import SwiftyJSON

class UserAPI {
    func register(name: String, id: String, password:String, gender:String, phone:String, profile:UIImage,completion:@escaping(JSON)->Void) {
        let parameters = [
            "name": name,
            "id": id,
            "password": password,
            "gender": gender,
            "phone": phone
        ]
        //Alamofire.request("http://aws.soylatte.kr:3000/auth/register", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON
        
        API.uploadAPI.upload(withURL: "http://aws.soylatte.kr:3000/auth/register", imageData: profile, parameters: parameters) { (response) in
            completion(response)
        }
        
        
    }
    
    func login(id: String,password: String,completion:@escaping(JSON)->Void) {
        var request = URLRequest(url: URL(string: "http://aws.soylatte.kr:3000/auth/login")!)
        request.httpMethod = HTTPMethod.post.rawValue
        //request.setValue("multipart/form-data", forHTTPHeaderField: "Content-type")
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        
        //let dataExample: Data = NSKeyedArchiver.archivedData(withRootObject: parameters)
        //let jsonData = try encoder.encode(post)
        if let serialize = try? JSONSerialization.data(withJSONObject: ["id":id,"password":password], options: .prettyPrinted) {
            request.httpBody = serialize
        }
        Alamofire.request(request).responseJSON { (response) in
            switch response.result {
            case .success(_):
                completion(JSON(response.result.value))
            case .failure(_):
                print("Error")
            }
        }
    }
}

