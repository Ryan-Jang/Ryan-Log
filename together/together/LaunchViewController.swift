//
//  LaunchViewController.swift
//  together
//
//  Created by admin on 2016. 10. 21..
//  Copyright © 2016년 장윤호. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {
    
    let app = UIApplication.shared
    let method: String = "POST"
    var params: String!
    var resultJson: String?
    var json: [String: AnyObject]?
    var result_code: NSNumber!
    var result_command: String!
    var min_ver: String!
    var now_ver: String!
    var now_pkg: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getVersion()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getVersion() {
        params = "command=VERSION_CHECK&PACKAGE_NAME=" + Bundle.main.bundleIdentifier!
        
        print(Bundle.main.bundleIdentifier!)
        
        CommToHttp.sharedInstance().StringRequest(method: method, api_url: CommParams.getUrl() + CommParams.URL_SERVER, params: params, complete: {(String) -> () in self.resultJson = String
        print(self.resultJson!)
        self.getJson()})
    }
    
    func getJson() {
        json = JsonParser.sharedInstance().parseJSONResults(jsonString: resultJson!)
        
        result_code = json?["result_code"] as! NSNumber!
        result_command = json?["result_command"] as! String!
        min_ver = json?["min_ver"] as! String!
        now_ver = json?["now_ver"] as! String!
        now_pkg = json?["now_pkg"] as! String!
        
        if result_command == "OK" {
            print("Version Check Success")
            checkVersion()
        } else {
            print("Version Check Fail")
        }
    }
    
    func checkVersion() {
        let cur_ver: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        let cur_vers: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
        
        print("cur_ver : ", cur_ver)
        print("cur_vers : ", cur_vers)
        
        let now_ver: Int = Int(cur_vers)!
        print("now :", now_ver)
        
        let min: Int = Int(min_ver)!
        
        if(min > now_ver) {
            print("버전이 낮아 업데이트를 해야합니다")
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(URL(string: "itms://itunes.apple.com/kr/app/id1027286616")!, options: [:], completionHandler: nil)
            } else {
                // Fallback on earlier versions
                UIApplication.shared.openURL(URL(string: "itms://itunes.apple.com/kr/app/id1027286616")!)
            }
        } else {
            let notificationSettings = UIUserNotificationSettings(types: UIUserNotificationType([.alert, .sound /*, .Badge*/]), categories:nil)
            app.registerUserNotificationSettings(notificationSettings)
            Intent()
        }
        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "MainViewController")
//        self.dismiss(animated: false, completion: nil)
//        self.present(vc, animated: true, completion: nil)
//        self.present(appDelegate.createViewController(), animated: true, completion: nil)
        
        
    }
    
    func Intent() {
        DispatchQueue.main.async {
            let appDelegate: AppDelegate = self.app.delegate as! AppDelegate
            appDelegate.createViewController()
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
