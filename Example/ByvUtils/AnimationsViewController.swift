//
//  AnimationsViewController.swift
//  ByvUtils
//
//  Created by Adrian Apodaca on 27/4/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

class AnimationsViewController: UIViewController {
    
    
    @IBOutlet var moveView: UIView!
    @IBOutlet weak var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changed(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            moveView.slideToTop()
            label.text = "slideToTop"
        case 1:
            moveView.slideToBottom()
            label.text = "slideToBottom"
        case 2:
            moveView.slideToLeft()
            label.text = "slideToLeft"
        case 3:
            moveView.slideToRight()
            label.text = "slideToRight"
        default:
            print("Algo va mal...")
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
