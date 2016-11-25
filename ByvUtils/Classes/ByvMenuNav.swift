//
//  ByvMenuNav.swift
//  Pods
//
//  Created by Adrian Apodaca on 21/11/16.
//
//

import UIKit

open class ByvMenuNav: UINavigationController {
    
    static open var instance:ByvMenuNav? = nil
    
    private var _leftTransition:ByvTransition = LeftMenuTransition()
    open var leftTransition:ByvTransition {
        get {
            return _leftTransition
        }
        set {
            _leftTransition = newValue
            if _leftMenu != nil {
                _leftMenu?.transitioningDelegate = _leftTransition
                _leftTransition.wireTo(viewController: self)
            }
        }
    }
    
    private var _leftMenu: UIViewController? = nil
    open var leftMenu: UIViewController? {
        get {
            return _leftMenu
        }
        set {
            _leftMenu = newValue
            if _leftTransition != nil {
                _leftMenu?.transitioningDelegate = _leftTransition
                _leftTransition.wireTo(viewController: self)
            }
        }
    }
    
    private var _leftMenuIdentifier: String = "ByvLeftMenuVC"
    open var leftMenuIdentifier: String {
        get {
            return _leftMenuIdentifier
        }
        set {
            _leftMenuIdentifier = newValue
            leftMenu = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: _leftMenuIdentifier)
        }
    }
    
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        ByvMenuNav.instance = self
    }

    override open func viewDidLoad() {
        super.viewDidLoad()
        
        if leftMenu == nil {
            leftMenuIdentifier = _leftMenuIdentifier
        }
        
        self.addLeftMenuButtonTo(self.viewControllers[0])
    }
    
    func addLeftMenuButtonTo(_ viewController: UIViewController) {
        let podBundle = Bundle(for: self.classForCoder)
        let url = podBundle.url(forResource: "ByvUtils", withExtension: "bundle")
        let imageBundle = Bundle(url: url!)
        var image = UIImage(named: "menuButton.png", in: imageBundle, compatibleWith: nil)
        image = UIImage(named: "menuButton.png")
        let menuBtn = UIBarButtonItem.init(image: image, style: .plain, target: self, action: #selector(showLeftMenu))
        viewController.navigationItem.leftBarButtonItem = menuBtn
    }
    
    public static func closeLeftMenu() {
        ByvMenuNav.instance?.leftMenu?.dismiss(animated: true, completion: nil)
    }
    
    public static func showLeftMenu() {
        ByvMenuNav.instance?.showLeftMenu()
    }
    
    func showLeftMenu() {
        if let vc = leftMenu {
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    open static func showModal(_ viewController: UIViewController, fromMenu: UIViewController?) {
        ByvMenuNav.instance?.showModal(viewController, fromMenu:fromMenu)
    }
    
    open func showModal(_ viewController: UIViewController, fromMenu: UIViewController?) {
        if let menu = fromMenu {
            menu.dismiss(animated: true, completion: {
                self.present(viewController, animated: true, completion: nil)
            })
        } else {
            self.present(viewController, animated: true, completion: nil)
        }
    }
    
    open static func setRoot(viewController: UIViewController, fromMenu: UIViewController?) {
        ByvMenuNav.instance?.setRoot([viewController], fromMenu:fromMenu)
    }
    
    open static func setRoot(viewControllers: Array<UIViewController>, fromMenu: UIViewController?) {
        ByvMenuNav.instance?.setRoot(viewControllers, fromMenu:fromMenu)
    }
    
    open func setRoot(_ viewControllers: Array<UIViewController>, fromMenu: UIViewController?) {
        if self.viewControllers != viewControllers {
            if let transition:LeftMenuTransition = leftTransition as? LeftMenuTransition {
                transition.onWideOpen = {
                    self.viewControllers = viewControllers
                    self.addLeftMenuButtonTo(viewControllers[0])
                }
            } else {
                self.viewControllers = viewControllers
                self.addLeftMenuButtonTo(viewControllers[0])
            }
        }
         if let menu = fromMenu {
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
