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
        if let rootVC = UIApplication.shared.keyWindow?.rootViewController {
            presentFromController(rootVC, animated: animated, completion: completion)
        }
    }
    
    fileprivate func presentFromController(_ controller: UIViewController, animated: Bool, completion: (() -> Void)?) {
        if let navVC = controller as? UINavigationController,
            let visibleVC = navVC.visibleViewController {
            presentFromController(visibleVC, animated: animated, completion: completion)
        } else
            if let tabVC = controller as? UITabBarController,
                let selectedVC = tabVC.selectedViewController {
                presentFromController(selectedVC, animated: animated, completion: completion)
            } else {
                controller.present(self, animated: animated, completion: completion);
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
