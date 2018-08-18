//
//  PartnerAPI.swift
//  sleep-only-with-hand
//
//  Created by 이창현 on 2018. 8. 19..
//  Copyright © 2018년 이창현. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

var couple_room_token:String = ""

class PartnerAPI {
    func make(partner_token: String,completion:@escaping(JSON)->Void) {
        var request = URLRequest(url: URL(string: "http://aws.soylatte.kr:3000/setting/partner")!)
        request.httpMethod = HTTPMethod.post.rawValue
        //request.setValue("multipart/form-data", forHTTPHeaderField: "Content-type")
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        
        //let dataExample: Data = NSKeyedArchiver.archivedData(withRootObject: parameters)
        //let jsonData = try encoder.encode(post)
        if let serialize = try? JSONSerialization.data(withJSONObject: ["token":token,"partner_token":partner_token,"d_day":0], options: .prettyPrinted) {
            request.httpBody = serialize
        }
        Alamofire.request(request).responseJSON { (response) in
            switch response.result {
            case .success(_):
                print(response.result.value)
                completion(JSON(response.result.value))
            case .failure(_):
                print("Error")
            }
        }
    }
    
    func check(completion:@escaping(String)->Void) {
        print(baseURL+"setting/get/partner/\(token)")
        Alamofire.request(baseURL+"setting/get/partner/\(token)").responseJSON { (response) in
            let json = JSON(response.result.value)
            print(json)
            completion(json["partner_data"]["user_data"]["name"].stringValue)
        }
        
    }
    
    func accept(with:Bool,completion:@escaping(JSON)->Void) {
        var request = URLRequest(url: URL(string: "http://aws.soylatte.kr:3000/setting/partner")!)
        request.httpMethod = HTTPMethod.post.rawValue
        //request.setValue("multipart/form-data", forHTTPHeaderField: "Content-type")
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        
        //let dataExample: Data = NSKeyedArchiver.archivedData(withRootObject: parameters)
        //let jsonData = try encoder.encode(post)
        if let serialize = try? JSONSerialization.data(withJSONObject: ["couple_room_token":couple_room_token,"accept":with], options: .prettyPrinted) {
            request.httpBody = serialize
        }
        Alamofire.request(request).responseJSON { (response) in
            switch response.result {
            case .success(_):
                print(response.result.value)
                completion(JSON(response.result.value))
            case .failure(_):
                print("Error")
            }
        }
    }
}
