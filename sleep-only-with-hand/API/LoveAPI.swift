//
//  LoveAPI.swift
//  sleep-only-with-hand
//
//  Created by 이창현 on 2018. 8. 18..
//  Copyright © 2018년 이창현. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class LoveAPI {
    func find_user(with:String,name:String,completion:@escaping ([JSON])->Void) {
        let url = with+"/\(name)"
        let encoded = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        print(encoded)
        Alamofire.request(URL(string: encoded)!, method: .get).responseJSON { (response) in
            let json = JSON(response.result.value)["data"].arrayValue
            
            
            completion(json)
            
        }
    }
}
