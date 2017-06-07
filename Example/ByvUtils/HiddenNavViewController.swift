//
//  HiddenNavViewController.swift
//  ByvUtils
//
//  Created by Adrian Apodaca on 9/5/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

open class HiddenNavViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    public var showWhenScrolledAt: CGFloat = 227
    public var startWhenScrolledAt: CGFloat = 163
    var maxScroll:CGFloat {
        get {
            return showWhenScrolledAt - startWhenScrolledAt
        }
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.barTintColor = UIColor.brown
        
        self.navigationController?.updateNavAlpha(0.0)
        
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.navigationController?.updateNavAlpha(0.0)
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.resetFromAlphaUpdates()
    }

    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func statusBarUpdate(_ sender: UISegmentedControl) {
        self.navigationController?.updateNavAlpha()
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

extension HiddenNavViewController: UIScrollViewDelegate {
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y + scrollView.contentInset.top
        let diff = offsetY - startWhenScrolledAt
        if (diff > 0) {
            let alpha:CGFloat = min (1, diff / maxScroll)
            self.navigationController?.updateNavAlpha(alpha)
        } else {
            self.navigationController?.updateNavAlpha(0)
        }
    }
    
}
