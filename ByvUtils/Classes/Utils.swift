//
//  Utils.swift
//  Pods
//
//  Created by Adrian Apodaca on 9/11/16.
//
//

import Foundation

func associatedObject<ValueType: AnyObject>(
    base: AnyObject,
    key: UnsafePointer<UInt8>,
    initialiser: () -> ValueType)
    -> ValueType {
        if let associated = objc_getAssociatedObject(base, key)
            as? ValueType { return associated }
        let associated = initialiser()
        objc_setAssociatedObject(base, key, associated,
                                 .OBJC_ASSOCIATION_RETAIN)
        return associated
}

func associateObject<ValueType: AnyObject>(
    base: AnyObject,
    key: UnsafePointer<UInt8>,
    value: ValueType) {
    objc_setAssociatedObject(base, key, value,
                             .OBJC_ASSOCIATION_RETAIN)
}

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
