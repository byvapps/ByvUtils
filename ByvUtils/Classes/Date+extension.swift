//
//  Date+extension.swift
//  Pods
//
//  Created by Adrian Apodaca on 17/2/17.
//
//

import Foundation

public extension Date {
    init(milliseconds: Double!) {
        self = Date(timeIntervalSince1970: Double(milliseconds/1000))
    }
    
    public static func fromMilliseconds(_ milliseconds: Double?) -> Date? {
        if let millis = milliseconds {
            return Date(timeIntervalSince1970: Double(millis/1000))
        }
        return nil
    }
    
    public static func fromMilliseconds(_ milliseconds: Double) -> Date {
        return Date(timeIntervalSince1970: Double(milliseconds/1000))
    }
    
    public func milliseconds() -> Double {
        return self.timeIntervalSince1970 * 1000
    }
    
    // Date: iso8601
    public var string: String {
        get {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
            return formatter.string(from: self)
        }
    }
}
