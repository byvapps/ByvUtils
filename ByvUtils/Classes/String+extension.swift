//
//  String.swift
//  Pods
//
//  Created by Adrian Apodaca on 9/11/16.
//
//

import Foundation

public extension String {
    
    // MARK: - Localization
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    
    // MARK: - length
    
    var length: Int {
        get {
            return self.lengthOfBytes(using: .utf8)
        }
    }
    
    // MARK: - contains
    
    // "Awesome".contains("me") == true
    // "Awesome".contains("Dude") == false
//    func contains(_ s: String) -> Bool
//    {
//        return (self.range(of: s) != nil) ? true : false
//    }
    
    // MARK: - Empty
    
    public static func isEmpty(_ s: Any?) -> Bool {
        if let s: String = s as? String {
            return s.isEmpty()
        }
        return true
    }
    
    func isEmpty() -> Bool {
        return self.replacingOccurrences(of: " ", with: "").length == 0
    }
    
    // MARK: - Email test
    
    // "email@test.com" == true
    // "email-test.com" == false
    func isEmail() -> Bool {
        if self.isEmpty() {
            return false
        }
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    // MARK: - Qr
    
    func QRCIImage(_ inputCorrectionLevel: String? = "M") -> CIImage? {
        let data = self.data(using: .utf8)
        let filter = CIFilter(name: "CIQRCodeGenerator")
        filter?.setValue(data, forKey: "inputMessage")
        filter?.setValue(inputCorrectionLevel, forKey: "inputCorrectionLevel")
        return filter?.outputImage
    }
    
    func QRImage(_ scale: CGFloat) -> UIImage? {
        let transform = CGAffineTransform(scaleX: scale, y: scale)
        if let img = self.QRCIImage()?.applying(transform) {
            return UIImage(ciImage: img)
        }
        return nil
    }
    
    // MARK: - Versions
    
    func isOlderThan(_ version: Any?) -> Bool {
        if let version2 = version as? String {
            let v1Comps = self.components(separatedBy: ".")
            let v2Comps = version2.components(separatedBy: ".")
            var count = v1Comps.count
            if v2Comps.count > count {
                count = v2Comps.count
            }
            for i in 0..<count {
                var v1 = 0
                if v1Comps.count > i {
                    v1 = Int(v1Comps[i]) ?? 0
                }
                
                var v2 = 0
                if v2Comps.count > i {
                    v2 = Int(v2Comps[i]) ?? 0
                }
                
                if v1 > v2 {
                    return false
                } else if v1 < v2 {
                    return true
                }
            }
        }
        return false
    }
    
    func isNewerThan(_ version: Any?) -> Bool {
        if let version2 = version as? String {
            let v1Comps = self.components(separatedBy: ".")
            let v2Comps = version2.components(separatedBy: ".")
            var count = v1Comps.count
            if v2Comps.count > count {
                count = v2Comps.count
            }
            for i in 0..<count {
                var v1 = 0
                if v1Comps.count > i {
                    v1 = Int(v1Comps[i]) ?? 0
                }
                
                var v2 = 0
                if v2Comps.count > i {
                    v2 = Int(v2Comps[i]) ?? 0
                }
                
                if v1 < v2 {
                    return false
                } else if v1 > v2 {
                    return true
                }
            }
        }
        return false
    }
}

