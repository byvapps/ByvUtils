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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addHorizontal(_ sender: Any) {
        for view in scroll.subviews {
            view.removeFromSuperview()
        }
        
        var subViews: Array<UIView> = []
        for index in 1...10 {
            let view = UIView()
            view.backgroundColor = UIColor.green
            let title = UILabel()
            title.text = "\(index)"
            title.textAlignment = .center
            title.addTo(view, height: 235.0)
            subViews.append(view)
        }
        
        scroll.add(subViews: subViews, direction: .horizontal, insets: UIEdgeInsetsMake(20, 20, 20, 20), margin: 10.0, size: 200.0)
    }

    @IBAction func addvertical(_ sender: Any) {
        for view in scroll.subviews {
            view.removeFromSuperview()
        }
        
        var subViews: Array<UIView> = []
        for index in 1...10 {
            let view = UIView()
            view.backgroundColor = UIColor.green
            let title = UILabel()
            title.text = "\(index)"
            title.textAlignment = .center
            title.addTo(view, width: 335.0)
            subViews.append(view)
        }
        
        scroll.add(subViews: subViews, direction: .vertical, insets: UIEdgeInsetsMake(20, 20, 20, 20), margin: 10.0, size: 200.0)
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
