//
//  AppDelegate.swift
//  together
//
//  Created by 장윤호 on 2016. 10. 11..
//  Copyright © 2016년 장윤호. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let characterSet: CharacterSet = CharacterSet( charactersIn: "<>" )
        
        let deviceTokenString: String = ( deviceToken.description as NSString )
            .trimmingCharacters(in: characterSet)
            .replacingOccurrences(of: " ", with: "")
        
        print( "노티피케이션 등록을 성공함, 디바이스 토큰 : \(deviceTokenString)" )
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func createViewController() {
        self.dismissPresentedViewController()
        
        let storyBoard: UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        let mainViewController: UIViewController = storyBoard.instantiateViewController(withIdentifier: "MainViewController")
        
        self.window?.rootViewController = mainViewController
        self.window?.makeKeyAndVisible()
    }
    
    func dismissPresentedViewController() {
        if self.window?.rootViewController?.presentedViewController != nil {
            self.window?.rootViewController?.dismiss(animated: false, completion: nil)
        }
    }


}

