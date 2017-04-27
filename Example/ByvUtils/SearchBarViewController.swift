//
//  SearchBarViewController.swift
//  ByvUtils
//
//  Created by Adrian Apodaca on 26/4/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import ByvUtils

class SearchBarViewController: UIViewController, UISearchControllerDelegate, UISearchBarDelegate {
    
    var searchController : UISearchController!
    
    @IBOutlet var segmented:UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()

//        self.navigationController?.navigationBar.barTintColor = .black
        
        self.searchController = UISearchController(searchResultsController:  nil)
        
        self.searchController.delegate = self
        self.searchController.searchBar.delegate = self
        
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.dimsBackgroundDuringPresentation = true
        
        self.navigationItem.titleView = searchController.searchBar
        
        self.definesPresentationContext = true
        
        
        searchController.searchBar.searchBarStyle = .minimal
        
        UISearchBar.appearance().changeBasedOnStatusBar = true
        
        self.navigationController?.navigationBar.barStyle = .black
        
    }
    
    @IBAction func changed(_ sender: UISegmentedControl) {
//        if sender.selectedSegmentIndex == 1 {
//            self.navigationController?.navigationBar.barStyle = .black
//            UISearchBar.appearance().changeBasedOnStatusBar = true
//        } else {
//            self.navigationController?.navigationBar.barStyle = .default
//            UISearchBar.appearance().changeBasedOnStatusBar = false
//            UISearchBar.appearance().changeBasedOnStatusBar = true
//        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
