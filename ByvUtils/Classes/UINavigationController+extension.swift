//
//  UINavigationViewController+extension.swift
//  Pods
//
//  Created by Adrian Apodaca on 25/5/17.
//
//

import Foundation

public class PreNavData {
    static public var assoKey: UInt8 = 0
    public var color:UIColor? = nil
    public var image:UIImage? = nil
    public var shadowImage:UIImage? = nil
    public var tint:UIColor? = nil
    public var barStyle:UIBarStyle = .default
    public var trans:Bool = true
    
    var loaded:Bool = false
    
    let gradient = CAGradientLayer()
    var gradientView:UIView = UIView()
    
    var navColor:UIColor = UIColor(white: 0.98, alpha: 0.84)
    var currentAlpha:CGFloat = 0.0
}

public extension UINavigationController {
    
    var preNavData: PreNavData {
        get {
            return associatedObject(base:self, key: &PreNavData.assoKey)
            { return PreNavData() } // Set the initial value of the var
        }
        set { associateObject(base:self, key: &PreNavData.assoKey, value: newValue) }
    }
    
    public func prepareForAlphaUpdates() {
        if preNavData.loaded {
            self.resetFromAlphaUpdates()
        }
        NotificationCenter.default.addObserver(self, selector: #selector(self.rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        let pre = PreNavData()
        pre.color = self.navigationBar.backgroundColor
        pre.image = self.navigationBar.backgroundImage(for: .default)
        pre.shadowImage = self.navigationBar.shadowImage
        pre.trans = self.navigationBar.isTranslucent
        pre.tint = self.navigationBar.tintColor
        pre.barStyle = self.navigationBar.barStyle
        pre.navColor = self.navigationBar.barTintColor ?? UIColor(white: 0.98, alpha: 0.84)
        pre.loaded = true
        
        var frame = self.navigationBar.bounds
        if !UIApplication.shared.isStatusBarHidden {
            frame.origin.y -= UIApplication.shared.statusBarFrame.height
            frame.size.height += UIApplication.shared.statusBarFrame.height
        }
        
        pre.gradient.frame = frame
        pre.gradient.colors = [UIColor(white: 0, alpha: 0.3).cgColor,
                               UIColor(white: 0, alpha: 0.0).cgColor]
        
        pre.gradientView.frame = frame
        pre.gradientView.backgroundColor = UIColor.clear
        pre.gradientView.layer.insertSublayer(pre.gradient, at: 0)
        self.navigationBar.addSubview(pre.gradientView)
        pre.gradientView.isUserInteractionEnabled = false
        self.navigationBar.sendSubview(toBack: pre.gradientView)
        
        self.preNavData = pre
        
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = true
    }
    
    public func resetFromAlphaUpdates() {
        NotificationCenter.default.removeObserver(self, name:  NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        self.navigationBar.backgroundColor = preNavData.color
        self.navigationBar.setBackgroundImage(preNavData.image, for: .default)
        self.navigationBar.shadowImage = preNavData.shadowImage
        self.navigationBar.isTranslucent = preNavData.trans
        self.navigationBar.tintColor = preNavData.tint
        self.navigationBar.barStyle = preNavData.barStyle
        
        preNavData.gradientView.removeFromSuperview()
        preNavData = PreNavData()
    }
    
    public func updateNavAlpha() {
        self.updateNavAlpha(preNavData.currentAlpha)
    }
    
    public func updateNavAlpha(_ alpha: CGFloat) {
        
        if !self.preNavData.loaded {
            self.prepareForAlphaUpdates()
        }
        
        if alpha > 0.0 {
            self.navigationBar.setBackgroundImage(preNavData.image, for: .default)
            self.navigationBar.shadowImage = preNavData.shadowImage
            self.navigationBar.tintColor = preNavData.tint
            self.navigationBar.barStyle = preNavData.barStyle
        } else {
            self.navigationBar.tintColor = UIColor.white
            self.navigationBar.barStyle = .black
            self.navigationBar.setBackgroundImage(UIImage(), for: .default)
            self.navigationBar.shadowImage = UIImage()
            self.navigationBar.isTranslucent = true
        }
        preNavData.currentAlpha = alpha
        preNavData.gradientView.alpha = 1 - preNavData.currentAlpha
        
        updateBakImageAlpha()
    }
    
    func rotated() {
        var frame = self.navigationBar.bounds
        if !UIApplication.shared.isStatusBarHidden {
            frame.size.height += UIApplication.shared.statusBarFrame.height
            frame.origin.y -= UIApplication.shared.statusBarFrame.height
        }
        preNavData.gradient.frame = frame
        preNavData.gradientView.frame = frame
        updateBakImageAlpha()
    }
    
    func updateBakImageAlpha() {
        if preNavData.currentAlpha == 1.0 {
            self.navigationBar.isTranslucent = preNavData.trans
            self.navigationBar.backgroundColor = preNavData.color
        } else {
            self.navigationBar.isTranslucent = true
            var finalAlpha = preNavData.currentAlpha
            if preNavData.trans {
                finalAlpha -= 0.025
            }
            if let img = preNavData.image {
                self.navigationBar.setBackgroundImage(img.alpha(preNavData.currentAlpha), for: .default)
            } else {
                self.navigationBar.setBackgroundImage(preNavData.navColor.withAlphaComponent(finalAlpha).asImage(self.navigationBar.bounds.size), for: .default)
            }
            if let color = preNavData.color {
                self.navigationBar.backgroundColor = color.withAlphaComponent(finalAlpha)
            }
        }
    }
    
}



public extension UIColor {
    public func asImage(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage? {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        self.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        return UIImage(cgImage: cgImage)
    }
}

public extension UIImage {
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
    
    func alpha(_ value:CGFloat)->UIImage
    {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
        
    }
}

public extension CALayer {
    public func asImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.frame.size, false, 0.0)
        self.render(in: UIGraphicsGetCurrentContext()!)
        let response = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return response
    }
}