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
    
    public static func json(_ data: Data?) -> [String: Any] {
        if let _data = data {
            do {
                if let anyObj = try JSONSerialization.jsonObject(with: _data) as? [String: Any] {
                    if let json:[String: Any] = anyObj  {
                        return json
                    }
                }
            } catch {
                print("json error: \(error.localizedDescription)")
            }
        }
        return [:]
    }
    
    public static func jsonArray(_ data: Data?) -> Array<[String: Any]> {
        if let _data = data {
            do {
                if let anyArray = try JSONSerialization.jsonObject(with: _data) as? Array<[String: Any]> {
                    if let array:Array<[String: Any]> = anyArray  {
                        return array
                    }
                }
            } catch {
                print("json error: \(error.localizedDescription)")
            }
        }
        return Array()
    }
    
    public static func cleanJson(_ json:[String: Any], withObject: Any? = nil) -> [String: Any] {
        
        return json
    }
}
