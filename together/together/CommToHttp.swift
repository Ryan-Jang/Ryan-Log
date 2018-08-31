//
//  CommToHttp.swift
//  together
//
//  Created by admin on 2016. 10. 21..
//  Copyright © 2016년 장윤호. All rights reserved.
//

import Foundation

class CommToHttp {
    struct StaticInstance {
        static var instance: CommToHttp?
    }
    
    class func sharedInstance() -> CommToHttp {
        if (StaticInstance.instance == nil) {
            StaticInstance.instance = CommToHttp()
        }
        return StaticInstance.instance!
    }
    
    public func StringRequest(method: String, api_url: String, params: String, complete: @escaping (String) -> ()) {
        let request = NSMutableURLRequest(url: NSURL(string: api_url)! as URL)
        
        let parametersString = params
        
        request.httpMethod = method
        request.httpBody = parametersString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            if error != nil {
                print("error = \(error)")
                return
            }
            
            print("response = \(response)")
            
            let responseString = String(data: data!, encoding: .utf8)
            print("responseString = \(responseString)")
            
            complete(responseString!)
        }
        task.resume()
    }
    
}
