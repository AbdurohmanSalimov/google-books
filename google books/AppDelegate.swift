//
//  AppDelegate.swift
//  google books
//
//  Created by Azizbek Salimov on 09/01/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
         window = UIWindow()
        
        let navVc = UINavigationController(rootViewController: MainTabbar() )
        
        self.window?.rootViewController = navVc
        self.window?.makeKeyAndVisible()
        
        return true
    }

  

}

