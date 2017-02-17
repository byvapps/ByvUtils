//
//  UIViewController+extension.swift
//  Pods
//
//  Created by Adrian Apodaca on 17/2/17.
//
//

import Foundation

public extension UIViewController {
    
    public static func presentFromVisibleViewController(viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?) {
        if UIApplication.shared.windows.count > 0, let presentVc = UIApplication.shared.windows[0].rootViewController {
            presentVc.presentFromVisibleViewController(viewControllerToPresent: viewControllerToPresent, animated: flag, completion: completion)
        }
    }
    
    public func presentFromVisibleViewController(viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?) {
        if self is UINavigationController {
            let navigationController = self as! UINavigationController
            navigationController.topViewController?.presentFromVisibleViewController(viewControllerToPresent: viewControllerToPresent, animated: true, completion: nil)
        } else if (presentedViewController != nil) {
            presentedViewController!.presentFromVisibleViewController(viewControllerToPresent: viewControllerToPresent, animated: true, completion: nil)
        } else {
            present(viewControllerToPresent, animated: true, completion: nil)
        }
    }
}
