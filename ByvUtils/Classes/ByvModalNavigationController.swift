//
//  ByvModalNavigationController.swift
//  Pods
//
//  Created by Adrian Apodaca on 21/11/16.
//
//

import UIKit

open class ByvModalNavigationController: UINavigationController {
    
    open var onlyInRoot:Bool = false
    open var dismissAnimated:Bool = true

    override open func viewDidLoad() {
        super.viewDidLoad()
        
        let closeBtn = UIBarButtonItem.init(barButtonSystemItem: .stop, target: self, action: #selector(closePressed))
        
        if onlyInRoot {
            self.viewControllers[0].navigationItem.leftBarButtonItem = closeBtn
        } else {
            self.viewControllers[0].navigationItem.rightBarButtonItem = closeBtn
        }
    }
    
    override open func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        if !onlyInRoot {
            let closeBtn = UIBarButtonItem.init(barButtonSystemItem: .stop, target: self, action: #selector(closePressed))
            viewController.navigationItem.rightBarButtonItem = closeBtn
        }
    }

    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func closePressed() {
        self.dismiss(animated: dismissAnimated, completion: nil)
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
