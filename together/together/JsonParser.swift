//
//  JsonParser.swift
//  together
//
//  Created by admin on 2016. 10. 21..
//  Copyright © 2016년 장윤호. All rights reserved.
//

import Foundation

class JsonParser {
    struct StaticInstance {
        static var instance: JsonParser?
    }
    
    class func sharedInstance() -> JsonParser {
        if (StaticInstance.instance == nil) {
            StaticInstance.instance = JsonParser()
        }
        return StaticInstance.instance!
    }
    
    func parseJSONResults(jsonString: String) -> [String: AnyObject]? {
        let data = jsonString.data(using: String.Encoding.utf8)
        
        do {
            if let data = data,
                let json = try JSONSerialization.jsonObject(with: data, options:[]) as? [String: AnyObject] {
                return json
            } else {
                print("No Data :/")
            }
        } catch {
            // 실패한 경우, 오류 메시지를 출력합니다.
            print("Error, Could not parse the JSON request")
        }
        
        return nil
    }
}
