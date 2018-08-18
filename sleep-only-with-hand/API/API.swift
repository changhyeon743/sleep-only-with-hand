//
//  API.swift
//  sleep-only-with-hand
//
//  Created by 이창현 on 2018. 8. 18..
//  Copyright © 2018년 이창현. All rights reserved.
//

import Foundation

let baseURL = "http://aws.soylatte.kr:3000/"

class API {
    static let uploadAPI = UploadAPI()
    static let userAPI = UserAPI()
    static let loveAPI = LoveAPI()
    static let partnerAPI = PartnerAPI()
    
}
