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
    
    public static func locale(currencyCode:String) -> Locale? {
        for identifier in Locale.availableIdentifiers {
            let locale = Locale(identifier: identifier)
            if locale.currencyCode?.uppercased() == currencyCode.uppercased() {
                return locale
            }
        }
        return nil
    }
    
    public static func currencySymbol(currencyCode:String) -> String? {
        return Utils.locale(currencyCode: currencyCode)?.currencySymbol
    }
    
    public static func hideBackButtonsTexts() {
        let attributes: [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 0.1),
            NSAttributedStringKey.foregroundColor: UIColor.clear]
        UIBarButtonItem.appearance().setTitleTextAttributes(attributes, for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes(attributes, for: .highlighted)
    }
}
