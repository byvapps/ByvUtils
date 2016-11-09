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
    
    // MARK: - length
    
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
    
    // MARK: - Empty
    
    static func isEmpty(_ s: Any?) -> Bool {
        if let s: String = s as? String {
            return s.empty()
        }
        return true
    }
    
    func empty() -> Bool {
        return self.replacingOccurrences(of: " ", with: "").length == 0
    }
    
    // MARK: - Email test
    
    // "email@test.com" == true
    // "email-test.com" == false
    func isEmail() -> Bool {
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
}
