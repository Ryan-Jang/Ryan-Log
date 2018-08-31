//
//  MyUiWebViewDelegate.swift
//  together
//
//  Created by 장윤호 on 2016. 10. 14..
//  Copyright © 2016년 장윤호. All rights reserved.
//

import UIKit
import WebKit

class MyWkWebViewDelegate: NSObject, WKNavigationDelegate {
    
    var indicator: UIActivityIndicatorView!
    var main: MainViewController!
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("start")
        indicator.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("finished")
        indicator.stopAnimating()
        CommParams.mURL = webView.url?.absoluteString
        print("mURL = ", CommParams.mURL!)
        checkBack(wv_main: webView)
        checkForward(wv_main: webView)
    }
    
    public func setIndicator(Indicator: UIActivityIndicatorView, Main: MainViewController) {
        self.indicator = Indicator
        self.main = Main
        print("setIndicator is done")
    }
    
    func checkBack(wv_main: WKWebView) {
        if (CommParams.mURL?.contains(CommParams.URL_MAIN))! {
            main.setBackEnable(enable: false)
        } else {
            if wv_main.canGoBack {
                main.setBackEnable(enable: true)
            } else {
                wv_main.load(URLRequest(url: NSURL(string: CommParams.getUrl()) as! URL))
                main.setBackEnable(enable: false)
            }
        }
    }
    
    func checkForward(wv_main: WKWebView) {
        if wv_main.canGoForward {
            main.setForwardEnable(enable: true)
        } else {
            main.setForwardEnable(enable: false)
        }
    }
}
