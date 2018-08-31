//
//  MyScriptMessageHandler.swift
//  together
//
//  Created by admin on 2016. 11. 3..
//  Copyright © 2016년 장윤호. All rights reserved.
//

import Foundation
import WebKit

class MyScriptMessageHandler: NSObject, WKScriptMessageHandler {
    
    func userContentController(_ userContentController: WKUserContentController, didReceive: WKScriptMessage) {
        if (didReceive.name == "App") {
            print(didReceive.name)
            if(didReceive.body as! String == "LOGIN") {
                print("login call")
            }
        }
    }
}
