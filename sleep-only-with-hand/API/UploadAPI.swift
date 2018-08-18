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
    func upload(withURL: String, imageData: UIImage,parameters: [String:String], completion: @escaping(JSON) -> Void) {

        let headers: HTTPHeaders = [
            "Content-type": "multipart/form-data"
        ]
        
        
        let request = NSMutableURLRequest(url: URL(string: withURL)!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("multipart/form-data", forHTTPHeaderField: "Content-type")
        // request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        
        //let dataExample: Data = NSKeyedArchiver.archivedData(withRootObject: parameters)
        //let jsonData = try encoder.encode(post)
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            if let image = UIImageJPEGRepresentation(imageData, 0.5) {
                multipartFormData.append(image, withName: "profile", fileName: "image.jpeg", mimeType: "image/jpeg")
                
                for (key, value) in parameters {
                    multipartFormData.append(value.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: key)
                }
            }
            
        }, with: request as! URLRequest, encodingCompletion: { (result) in
            switch result {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    //debugPrint(response)
                    let data = JSON(response.result.value)
                    
                    //print(data)
                    completion(data)
                    
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")

            }

        })
        
        
        
    }
}
