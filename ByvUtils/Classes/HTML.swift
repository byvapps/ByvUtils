//
//  HTML.swift
//  ByvUtils
//
//  Created by Adrian Apodaca on 9/5/18.
//

import Foundation

public extension String {
    public var html2AttributedString: NSAttributedString? {
        return Data(utf8).html2AttributedString
    }
    
    public var html2String: String {
        return html2AttributedString?.string ?? ""
    }
    
    public func html2AttributedString(styleStr: String) -> NSAttributedString? {
        let htmlStr = "\(styleStr)\(self)"
        return htmlStr.html2AttributedString
    }
}

public extension Data {
    
    public var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    
    public var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}
