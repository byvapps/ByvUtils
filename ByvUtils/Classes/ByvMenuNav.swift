//
//  ByvMenuNav.swift
//  Pods
//
//  Created by Adrian Apodaca on 21/11/16.
//
//

import UIKit

public protocol ByvMenu : NSObjectProtocol {
    func transition() -> ByvTransition
    func loadTransition()
}

open class ByvMenuNav: UINavigationController, UINavigationControllerDelegate {
    
    static open var instance:ByvMenuNav? = nil
    
    private var _leftMenu: ByvMenu? = nil
    open var leftMenu: ByvMenu? {
        get {
            return _leftMenu
        }
        set {
            _leftMenu = newValue
            leftMenu?.loadTransition()
            self.addLeftMenuButtonTo(self.viewControllers[0])
        }
    }
    
    private var _leftMenuIdentifier: String = "ByvLeftMenuVC"
    open var leftMenuIdentifier: String {
        get {
            return _leftMenuIdentifier
        }
        set {
            _leftMenuIdentifier = newValue
            if let menu:ByvMenu = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: _leftMenuIdentifier) as? ByvMenu {
                leftMenu = menu
            }
        }
    }
    
    private var _leftMenuImage: UIImage? = nil
    open var leftMenuImage: UIImage? {
        get {
            if _leftMenuImage == nil {
                let podBundle = Bundle(for: self.classForCoder)
                _leftMenuImage = UIImage(named: "menuButton.png", in: podBundle, compatibleWith: nil)
            }
            return _leftMenuImage
        }
        set {
            _leftMenuImage = newValue
            addLeftMenuButtonTo(self.viewControllers[0])
        }
    }
    
    private var _backImage: UIImage? = nil
    open var backImage: UIImage? {
        get {
            if _backImage == nil {
                let podBundle = Bundle(for: self.classForCoder)
                _backImage = UIImage(named: "back.png", in: podBundle, compatibleWith: nil)
            }
            return _backImage
        }
        set {
            _backImage = newValue
        }
    }
    
    public var allwaysShowLeftMenuButton = false
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        ByvMenuNav.instance = self
    }
    
    public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if let leftMenu = leftMenu {
            if navigationController.viewControllers.index(of: viewController) == 0 || allwaysShowLeftMenuButton {
                addLeftMenuButtonTo(viewController)
            }
        }
    }

    override open func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        if leftMenu == nil {
            leftMenuIdentifier = _leftMenuIdentifier
        }
    }
    
    func addLeftMenuButtonTo(_ viewController: UIViewController) {
        let menuBtn = UIBarButtonItem.init(image: leftMenuImage, style: .plain, target: self, action: #selector(showLeftMenu))
        var buttons: Array<UIBarButtonItem> = [menuBtn]
        
        if let button = viewController.navigationItem.leftBarButtonItem, let target = button.target as? UIViewController, target != self {
            buttons.insert(button, at: 0)
        } else {
            if let items = viewController.navigationItem.leftBarButtonItems {
                for button in items {
                    if let target = button.target as? UIViewController, target != self {
                        buttons.insert(button, at: 0)
                    }
                }
            }
        }
//        if self.viewControllers.index(of: viewController) != 0 && allwaysShowLeftMenuButton {
//            let button = UIBarButtonItem.init(image: leftMenuImage, style: .plain, target: self, action: #selector(popViewController(animated:)))
//            buttons.insert(button, at: 0)
//        }
        viewController.navigationItem.leftItemsSupplementBackButton = true
        viewController.navigationItem.leftBarButtonItems = buttons
    }
    
    public static func closeLeftMenu() {
        (ByvMenuNav.instance?.leftMenu as? UIViewController)?.dismiss(animated: true, completion: nil)
    }
    
    public static func showLeftMenu() {
        ByvMenuNav.instance?.showLeftMenu()
    }
    
    func showLeftMenu() {
        if let vc = leftMenu as? UIViewController {
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    open static func showModal(_ viewController: UIViewController, fromMenu: ByvMenu?) {
        ByvMenuNav.instance?.showModal(viewController, fromMenu:fromMenu)
    }
    
    open func showModal(_ viewController: UIViewController, fromMenu: ByvMenu?) {
        if let menu = fromMenu as? UIViewController {
            menu.dismiss(animated: true, completion: {
                self.present(viewController, animated: true, completion: nil)
            })
        } else {
            self.present(viewController, animated: true, completion: nil)
        }
    }
    
    open static func setRoot(viewController: UIViewController, fromMenu: ByvMenu?) {
        ByvMenuNav.instance?.setRoot([viewController], fromMenu:fromMenu)
    }
    
    open static func setRoot(viewControllers: Array<UIViewController>, fromMenu: ByvMenu?) {
        ByvMenuNav.instance?.setRoot(viewControllers, fromMenu:fromMenu)
    }
    
    open func setRoot(_ viewControllers: Array<UIViewController>, fromMenu: ByvMenu?) {
        if self.viewControllers != viewControllers {
            if let menu = fromMenu, let transition:LeftMenuTransition = menu.transition() as? LeftMenuTransition {
                transition.onWideOpen = {
                    self.viewControllers = viewControllers
                    if fromMenu != nil && fromMenu as? UIViewController == self.leftMenu as? UIViewController {
                        self.addLeftMenuButtonTo(self.viewControllers[0])
                    }
                }
            } else {
                self.viewControllers = viewControllers
                if fromMenu != nil && fromMenu as? UIViewController == self.leftMenu as? UIViewController {
                    self.addLeftMenuButtonTo(self.viewControllers[0])
                }
            }
        }
        if let menu = fromMenu as? UIViewController {
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
