//
//  Date+extension.swift
//  Pods
//
//  Created by Adrian Apodaca on 17/2/17.
//
//

import Foundation

public extension Date {
    public static func fromMilliseconds(_ milliseconds: Int?) -> Date? {
        if let millis = milliseconds {
            return Date(timeIntervalSince1970: Double(millis/1000))
        }
        return nil
    }
    
    public static func fromMilliseconds(_ milliseconds: Int) -> Date {
        return Date(timeIntervalSince1970: Double(milliseconds/1000))
    }
    
    public func milliseconds() -> Double {
        return self.timeIntervalSince1970 * 1000
    }
}
