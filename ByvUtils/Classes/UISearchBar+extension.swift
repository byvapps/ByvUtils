//
//  UISearchBar+extension.swift
//  Pods
//
//  Created by Adrian Apodaca on 26/4/17.
//
//

import Foundation

public extension UISearchBar {
    
    public var textField:UITextField? {
        get {
            return self.value(forKey: "searchField") as? UITextField
        }
    }
    
    public var textColor:UIColor? {
        get {
            return self.textField?.textColor
        }
        set {
            self.textField?.textColor = newValue
        }
    }
    
    public var changeBasedOnStatusBar:Bool {
        get {
            if self.searchBarStyle == .minimal {
                let style = UIApplication.shared.keyWindow?.rootViewController?.preferredStatusBarStyle
                return self.textField?.textColor == .white && style == .lightContent
            }
            return false
        }
        set {
            if self.searchBarStyle == .minimal {
                if newValue, let navBar = self.navigationBarIn {
                    if navBar.barStyle == .default {
                        self.textField?.textColor = .black
                    } else {
                       self.textField?.textColor = .white
                    }
                } else {
                    self.textField?.textColor = .black
                }
            }
        }
    
    }
}
