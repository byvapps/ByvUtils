//
//  ByvMenuNavigationViewController.swift
//  Pods
//
//  Created by Adrian Apodaca on 21/11/16.
//
//

import UIKit

open class ByvMenuNavigationViewController: UINavigationController {
    
    static open var sharedInstance:ByvMenuNavigationViewController? = nil
    
    open var menuViewController: UIViewController? = nil
    open var menuViewControllerMainStoryboardIdentifier: String = "ByvMenuViewController"
    
    open var transition:MenuTransition = MenuTransition()
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        ByvMenuNavigationViewController.sharedInstance = self
    }

    override open func viewDidLoad() {
        super.viewDidLoad()
        
        if menuViewController == nil {
            menuViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: menuViewControllerMainStoryboardIdentifier)
            menuViewController?.transitioningDelegate = transition
            transition.wireToViewController(viewController: self)
        }
        
        self.addMenuButtonTo(self.viewControllers[0])
    }
    
    func addMenuButtonTo(_ viewController: UIViewController) {
        let podBundle = Bundle(for: self.classForCoder)
        let url = podBundle.url(forResource: "ByvUtils", withExtension: "bundle")
        let imageBundle = Bundle(url: url!)
        let image = UIImage(named: "menuButton.png", in: imageBundle, compatibleWith: nil)
        let menuBtn = UIBarButtonItem.init(image: image, style: .plain, target: self, action: #selector(showMenu))
        viewController.navigationItem.leftBarButtonItem = menuBtn
    }
    
    public static func closeMenu() {
        ByvMenuNavigationViewController.sharedInstance?.menuViewController?.dismiss(animated: true, completion: nil)
    }
    
    public static func showMenu() {
        ByvMenuNavigationViewController.sharedInstance?.showMenu()
    }
    
    func showMenu() {
        if let vc = menuViewController {
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    open static func showModal(_ viewController: UIViewController) {
        ByvMenuNavigationViewController.sharedInstance?.showModal(viewController)
    }
    
    open func showModal(_ viewController: UIViewController) {
        if let menu = self.menuViewController {
            menu.dismiss(animated: true, completion: {
                self.present(viewController, animated: true, completion: nil)
                self.addMenuButtonTo(viewController)
            })
        }
    }
    
    open static func setRoot(_ viewController: UIViewController) {
        ByvMenuNavigationViewController.sharedInstance?.setRoot(viewController)
    }
    
    open func setRoot(_ viewController: UIViewController) {
        if let menu = self.menuViewController {
            if self.viewControllers.count != 1 || self.viewControllers[0] != viewController {
                self.transition.onWideOpen = {
                    if self.viewControllers[0] == viewController {
                        self.popToRootViewController(animated: false)
                    } else {
                        ByvMenuNavigationViewController.sharedInstance?.viewControllers = [viewController]
                        self.addMenuButtonTo(viewController)
                    }
                }
            }
            menu.dismiss(animated: true, completion: nil)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
