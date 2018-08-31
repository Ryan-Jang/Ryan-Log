//
//  ViewController.swift
//  together
//
//  Created by 장윤호 on 2016. 10. 11..
//  Copyright © 2016년 장윤호. All rights reserved.
//

import UIKit
import WebKit

class MainViewController: UIViewController {

    @IBOutlet weak var containView: UIView!
    @IBOutlet weak var myActivityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var btnBack: UIBarButtonItem!
    @IBOutlet weak var btnForward: UIBarButtonItem!
    @IBOutlet weak var toolBar: UIToolbar!
    
    var wv_main: WKWebView!
    let mainURL = CommParams.getUrl()
    var loadURL: NSURL!
    var myRequest: URLRequest!
    
    let userAgent = "MobileApp IOS"
    let myDelegate: MyWkWebViewDelegate = MyWkWebViewDelegate()
    let myScrollDelegate: MyScrollViewDelegate = MyScrollViewDelegate()
    var contentController = WKUserContentController()
    let myScript = MyScriptMessageHandler()
    var myConfig = WKWebViewConfiguration()
    
    let identifier = Bundle.main.bundleIdentifier
    
    var appAgent: String!
    var updownConstraints: [NSLayoutConstraint]?
    var toolBarHeight: CGFloat?
    var count = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print("Main did load")
        
        if wv_main != nil {
            print("wv isn't nil")
        } else {
            print("wv is nil")
        }
        
        myDelegate.setIndicator(Indicator: myActivityIndicatorView, Main: self)
        myScrollDelegate.setToolBar(bar: toolBar, Main: self)
        
        contentController.add(myScript, name: "App")
        myConfig.userContentController = contentController
        
        wv_main = WKWebView(frame: self.containView.frame, configuration: myConfig)
        
        wv_main.navigationDelegate = myDelegate
        wv_main.scrollView.delegate = myScrollDelegate
        
        containView.addSubview(wv_main!)
        containView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[wv]|", options: [], metrics: nil, views: ["wv": wv_main]))
        containView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[wv]|", options: [], metrics: nil, views: ["wv": wv_main]))
        
        wv_main.translatesAutoresizingMaskIntoConstraints = false
        
        //        self.view.addConstraint(NSLayoutConstraint (item: self.wv_main, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: self.toolBar, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: 0))
        //        self.view.addConstraint(NSLayoutConstraint (item: self.wv_main, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: 0))
        //        self.view.addConstraint(NSLayoutConstraint (item: self.wv_main, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.left, multiplier: 1.0, constant: 0))
        //        self.view.addConstraint(NSLayoutConstraint (item: self.wv_main, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.right, multiplier: 1.0, constant: 0))
        
        let swipeLeft = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(MainViewController.respondToEdge(gesture:)))
        swipeLeft.edges = .left
        self.wv_main.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(MainViewController.respondToEdge(gesture:)))
        swipeRight.edges = .right
        self.wv_main.addGestureRecognizer(swipeRight)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("Main did appear")
        
        appAgent = userAgent + " / " + identifier!
        UserDefaults.standard.register(defaults: ["UserAgent": appAgent])
        print(UserDefaults.standard.string(forKey: "UserAgent")!)
        
        loadURL = NSURL(string: mainURL)
        myRequest = URLRequest(url: loadURL as URL)
        
        wv_main.load(myRequest)
        
        updownConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[tg][cv][bg]|", options: [], metrics: nil, views: ["cv": containView, "tg": self.topLayoutGuide, "bg": self.bottomLayoutGuide])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func respondToEdge(gesture: UIScreenEdgePanGestureRecognizer) {
        if gesture.state == .recognized {
            switch gesture.edges {
            case UIRectEdge.left:
                if (CommParams.mURL?.contains(CommParams.URL_MAIN))! {
                    return
                } else {
                    if wv_main.canGoBack {
                        wv_main.goBack()
                    } else {
                        wv_main.load(URLRequest(url: NSURL(string: CommParams.getUrl()) as! URL))
                    }
                }
            case UIRectEdge.right:
                if wv_main.canGoForward {
                    wv_main.goForward()
                }
            default :
                break
            }
        }
    }
    
    public func reSizeToolBar(bool: Bool) {
        print("resizeToolbar")
        
        if bool {
            print(bool)
            
            if(count < 1) {
                self.view.addConstraints(updownConstraints!)
                count += 1
            }
        } else {
            print(bool)
            
            self.view.removeConstraints(updownConstraints!)
            count = 0
        }
        
        containView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    @IBAction func btnGoBack(_ sender: UIBarButtonItem) {
        wv_main.goBack()
    }
    
    @IBAction func btnGoForward(_ sender: UIBarButtonItem) {
        wv_main.goForward()
    }    
    
    public func setBackEnable(enable: Bool) {
        btnBack.isEnabled = enable
    }
    
    public func setForwardEnable(enable: Bool) {
        btnForward.isEnabled = enable
    }

}

