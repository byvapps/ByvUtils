//
//  UIImage+extension.swift
//  Pods
//
//  Created by Adrian Apodaca on 17/2/17.
//
//

import Foundation

public extension UIImage {
    
    /// Returns a image that fills in newSize
    func resizedImageToSize(_ newSize: CGSize) -> UIImage {
        // Guard newSize is different
        guard self.size != newSize else { return self }
        
        UIGraphicsBeginImageContext(size)
        self.draw(in: CGRect(x:0, y:0, width:size.width, height:size.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    /// Returns a resized image that fits in rectSize, keeping it's aspect ratio
    /// Note that the new image size is not rectSize, but within it.
    func resizedImageToMaxSize(_ maxSize: CGSize) -> UIImage {
        let widthFactor = size.width / maxSize.width
        let heightFactor = size.height / maxSize.height
        
        var resizeFactor = widthFactor
        if size.height > size.width {
            resizeFactor = heightFactor
        }
        
        let newSize = CGSize(width: size.width/resizeFactor, height: size.height/resizeFactor)
        let resized = resizedImageToSize(newSize)
        return resized
    }
    
}
