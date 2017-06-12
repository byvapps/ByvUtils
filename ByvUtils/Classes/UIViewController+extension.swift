//
//  UIViewController+extension.swift
//  Pods
//
//  Created by Adrian Apodaca on 17/2/17.
//
//

import Foundation

public extension UIViewController {
    
    public static func presentFromVisibleViewController(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?) {
        if UIApplication.shared.windows.count > 0, let presentVc = UIApplication.shared.windows[0].rootViewController {
            presentVc.presentFromVisibleViewController(viewControllerToPresent, animated: flag, completion: completion)
        }
    }
    
    public func presentFromVisibleViewController(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?) {
        if self is UINavigationController {
            let navigationController = self as! UINavigationController
            navigationController.topViewController?.presentFromVisibleViewController(viewControllerToPresent, animated: true, completion: nil)
        } else if (presentedViewController != nil) {
            presentedViewController!.presentFromVisibleViewController(viewControllerToPresent, animated: true, completion: nil)
        } else {
            present(viewControllerToPresent, animated: true, completion: nil)
        }
    }
    
    public func removeBackButtonText() {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
    }
}
