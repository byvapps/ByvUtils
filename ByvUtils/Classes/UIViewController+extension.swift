//
//  UIViewController+extension.swift
//  Pods
//
//  Created by Adrian Apodaca on 17/2/17.
//
//

import Foundation

public extension UIViewController {
    
    public static var top: UIViewController? {
        get {
            return topViewController()
        }
    }
    
    public static var root: UIViewController? {
        get {
            return UIApplication.shared.delegate?.window??.rootViewController
        }
    }
    
    public static func topViewController(from viewController: UIViewController? = UIViewController.root) -> UIViewController? {
        if let tabBarViewController = viewController as? UITabBarController {
            return topViewController(from: tabBarViewController.selectedViewController)
        } else if let navigationController = viewController as? UINavigationController {
            return topViewController(from: navigationController.visibleViewController)
        } else if let presentedViewController = viewController?.presentedViewController {
            return topViewController(from: presentedViewController)
        } else {
            return viewController
        }
    }
    
    public static func presentFromVisibleViewController(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?) {
        if let presentVc = self.top {
            presentVc.presentFromVisibleViewController(viewControllerToPresent, animated: flag, completion: completion)
        }
    }
    
    public func presentFromVisibleViewController(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?) {
        if let presentVc = UIViewController.topViewController(from:self) {
            presentVc.presentFromVisibleViewController(viewControllerToPresent, animated: flag, completion: completion)
        }
    }
    
    public func removeBackButtonText() {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
    }
}
