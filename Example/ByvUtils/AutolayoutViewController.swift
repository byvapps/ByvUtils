//
//  AutolayoutViewController.swift
//  ByvUtils
//
//  Created by Adrian Apodaca on 12/12/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import ByvUtils

class AutolayoutViewController: UIViewController {

    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var removeBtn: UIButton!
    @IBOutlet weak var green: UIView!
    
    var viewToRemove: UIView = UIView()
    var preViewToRemove: UIView? = nil
    var postViewToRemove: UIView? = nil
    var isVertical:Bool = true
    var is2ndViewRemoved = false
    
    let indexToRemove = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addvertical(nil)
        
        green.removeFromSuperview()
        green.addTo(self.view, position: .topRight, insets:UIEdgeInsetsMake(75, 16, 16, 16), width: 50, height: 50)
        
        self.title = "Autolayout"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addHorizontal(_ sender: Any?) {
        
        for view in scroll.subviews {
            view.removeFromSuperview()
        }
        
        isVertical = false
        
        var subViews: Array<UIView> = []
        for index in 1...10 {
            let view = UIView()
            view.backgroundColor = UIColor.green
            let title = UILabel()
            title.text = "\(index)"
            title.textAlignment = .center
            title.addTo(view, height: 235.0)
            subViews.append(view)
            
            if index == indexToRemove - 1 {
                preViewToRemove = view
            } else if index == indexToRemove {
                viewToRemove = view
            } else if index == indexToRemove + 1 {
                postViewToRemove = view
            }
        }
        
        scroll.add(subViews: subViews, direction: .horizontal, insets: UIEdgeInsetsMake(20, 20, 20, 20), margin: 10.0, size: 200.0)
    }

    @IBAction func addvertical(_ sender: Any?) {
        for view in scroll.subviews {
            view.removeFromSuperview()
        }
        
        isVertical = true
        
        var subViews: Array<UIView> = []
        for index in 1...10 {
            let view = UIView()
            view.backgroundColor = UIColor.green
            let title = UILabel()
            title.text = "\(index)"
            title.textAlignment = .center
            title.addTo(view, width: 335.0)
            subViews.append(view)
            
            if index == indexToRemove - 1 {
                preViewToRemove = view
            } else if index == indexToRemove {
                viewToRemove = view
            } else if index == indexToRemove + 1 {
                postViewToRemove = view
            }
        }
        
        scroll.add(subViews: subViews, direction: .vertical, insets: UIEdgeInsetsMake(20, 20, 20, 20), margin: 10.0, size: 200.0)
    }
    
    @IBAction func change2ndView(_ sender: UIButton) {
        if sender.titleLabel?.text == "Remove 2nd View" {
            //Remove
            sender.setTitle("Add 2nd View", for: .normal)
            if isVertical {
//                viewToRemove.hideInVertical(margin: 30, animated: true)
                viewToRemove.removeInVertical(margin: 30)
            } else {
//                viewToRemove.hideInHorizontal(margin: 30, animated: true)
                viewToRemove.removeInHorizontal(margin: 30)
            }
        } else {
            //Add
            sender.setTitle("Remove 2nd View", for: .normal)
            if isVertical {
//                viewToRemove.showInVertical(animated: true)
                viewToRemove.insertVetical(in: scroll, top: preViewToRemove, bottom: postViewToRemove, insets: UIEdgeInsetsMake(10, 20, 10, 20))
            } else {
//                viewToRemove.showInHorizontal(animated: true)
                viewToRemove.insertHorizontal(in: scroll, left: preViewToRemove, right: postViewToRemove, insets: UIEdgeInsetsMake(10, 20, 10, 20))
            }
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
