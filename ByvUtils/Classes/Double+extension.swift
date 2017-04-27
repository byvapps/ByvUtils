//
//  Double+extension.swift
//  Pods
//
//  Created by Adrian Apodaca on 27/4/17.
//
//

import Foundation

public extension Double {
    
    public func asEuros(decimals:Int = 2) -> String {
        return self.asCurrency(locale: Locale(identifier: "es_ES"), decimals:decimals)
    }
    
    public func asMyCurrency(decimals:Int = 2) -> String {
        return self.asCurrency(locale: Locale.current, decimals:decimals)
    }
    
    public func asCurrency(currencyCode: String, decimals:Int = 2) -> String {
        if let locale = Utils.locale(currencyCode: currencyCode) {
            return self.asCurrency(locale: locale, decimals:decimals)
        }
        return String(self)
    }
    
    public func asCurrency(locale: Locale, decimals:Int = 2) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = decimals;
        formatter.locale = Locale(identifier: Locale.current.identifier)
        if let result = formatter.string(from: NSNumber(value: self)) {
            return result
        }
        return String(self)
    }
    
    
    public func roundTo(decimals: Int) -> Double {
        let divisor = pow(10.0, Double(decimals))
        return (self * divisor).rounded() / divisor
    }
    
    public func cleanString() -> String {
        return self / 1 == 0 ? String(format: "%.0f", self) : String(self)
    }
}
