//
//  String.swift
//  Pods
//
//  Created by Adrian Apodaca on 9/11/16.
//
//

import Foundation



extension String {
    
    // MARK: - Localization
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    
    var length: Int {
        get {
            return self.lengthOfBytes(using: .utf8)
        }
    }
    
    // "Awesome".contains("me") == true
    // "Awesome".contains("Dude") == false
    func contains(s: String) -> Bool
    {
        return (self.range(of: s) != nil) ? true : false
    }
    
    static func isEmpty(_ s: String?) -> Bool {
        if let s = s {
            return s.empty()
        }
        return true
    }
    
    func empty() -> Bool {
        return self.replacingOccurrences(of: " ", with: "").length == 0
    }
    
    // "email@test.com" == true
    // "email-test.com" == false
    func isEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
}

