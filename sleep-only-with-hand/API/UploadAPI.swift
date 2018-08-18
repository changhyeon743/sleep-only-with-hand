//
//  postAPI.swift
//  sleep-only-with-hand
//
//  Created by 이창현 on 2018. 8. 18..
//  Copyright © 2018년 이창현. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class UploadAPI {
    //(endUrl: String, imageData: Data?, parameters: [String : Any], onCompletion: ((JSON?) -> Void)? = nil, onError: ((Error?) -> Void)? = nil
    
    
    //completion 외에도 error 넣기
    func upload(withURL: String, imageData: Data?, completion: @escaping(JSON) -> Void) {
        let url = withURL /* your API url */
        
        let headers: HTTPHeaders = [
            /* "Authorization": "your_access_token",  in case you need authorization header */
            "Content-type": "multipart/form-data"
        ]
        
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            if let data = imageData {
                multipartFormData.append(data, withName: "profile")
            }
        }, to: url, method: .post, headers: headers, encodingCompletion: { (result) in
            switch result {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    if let err = response.error{
                        print(err.localizedDescription)
                        return
                    }
                    print("Succesfully uploaded")

                    if let result = response.result.value {
                        completion(JSON(result))
                    }
                }
            case .failure(let error):
                print("Error in upload: \(error.localizedDescription)")

            }

        })
        
        
        
    }
}
