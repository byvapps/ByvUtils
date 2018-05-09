//
//  UIAlertController.swift
//  Pods
//
//  Created by Adrian Apodaca on 21/11/16.
//
//

import Foundation

public extension UIAlertController {
    
    func show() {
        present(true, completion: nil)
    }
    
    func present(_ animated: Bool, completion: (() -> Void)?) {
        if let vc = UIViewController.top {
            vc.present(self, animated: animated, completion: completion)
        }
    }
    
    static func alertWith(title: String?, message: String?, closeButtonTitle: String?) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if let closeButtonTitle = closeButtonTitle {
            let action = UIAlertAction(title: closeButtonTitle, style: .cancel, handler: nil)
            alertController.addAction(action)
        }
        
        return alertController
    }
}
