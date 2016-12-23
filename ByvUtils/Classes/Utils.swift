//
//  Utils.swift
//  Pods
//
//  Created by Adrian Apodaca on 9/11/16.
//
//

import Foundation

public struct Utils {
    
    public static func showTabBar() {
        if let tab: UITabBarController = UIApplication.shared.windows[0].rootViewController as? UITabBarController {
            tab.tabBar.isHidden = false
        }
    }
    
    public static func hideTabBar() {
        if let tab: UITabBarController = UIApplication.shared.windows[0].rootViewController as? UITabBarController {
            tab.tabBar.isHidden = true
        }
    }
    
    public static func setLanguage(code: String) {
        UserDefaults.standard.set([code], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
    }
}
