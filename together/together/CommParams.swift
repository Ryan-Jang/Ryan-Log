//
//  CommParams.swift
//  together
//
//  Created by 장윤호 on 2016. 10. 19..
//  Copyright © 2016년 장윤호. All rights reserved.
//

import Foundation

class CommParams {
    public static let ISTEST: Bool = false
    
    public static var mURL: String?
    
    public static let URL: String = "https://www.together.co.kr"
    public static let URL_TEST: String = "http://dev.together.co.kr"
    public static let URL_MAIN: String = "/menu/index.php?menu=main"
    public static let URL_SERVER: String = "/app/index.php"
    
    public static func getUrl() -> String {
        if (!ISTEST) {
            return URL;
        } else {
            return URL_TEST;
        }
    }
}
