//
//  CALayer+extension.swift
//  Pods
//
//  Created by Adrian Apodaca on 17/2/17.
//
//

import Foundation

@IBDesignable
public extension CALayer {
    
    @IBInspectable
    public var borderIBColor:UIColor? {
        set {
            borderColor = newValue?.cgColor
        }
        get {
            var color:UIColor? = nil
            if let cgColor = borderColor {
                color = UIColor(cgColor: cgColor)
            }
            return color
        }
    }
    
    @IBInspectable
    public var shadowIBColor:UIColor? {
        set {
            shadowColor = newValue?.cgColor
        }
        get {
            var color:UIColor? = nil
            if let cgColor = shadowColor {
                color = UIColor(cgColor: cgColor)
            }
            return color
        }
    }
}
