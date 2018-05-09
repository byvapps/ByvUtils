//
//  ViewController.swift
//  ByvUtils
//
//  Created by Adrian on 11/09/2016.
//  Copyright (c) 2016 Adrian. All rights reserved.
//

import UIKit
import ByvUtils

class ExampleViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func createQr(_ sender: Any) {
        if let qrStr:String = textField.text, let img:UIImage = qrStr.QRImage(5.0) {
            imageView.image = img
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Big long title text"
        
        textField.textColor = UIColor(hex: "#00FF00")
        
        // length
        
        print("versions:\n")
        
        var s = "Hellow world!!!"
        
        print("The string \"\(s)\" is \(s.length) length")
        
        // Contains
        
        print("\n\ncontains:\n")
        
        var word = "world"
        
        if s.contains(word) {
            print("\"\(s)\" contains \"\(word)\"")
        } else {
            print("\"\(s)\" didn't contains \"\(word)\"")
        }
        
        word = "Adrian"
        
        if s.contains(word) {
            print("\"\(s)\" contains \"\(word)\"")
        } else {
            print("\"\(s)\" didn't contains \"\(word)\"")
        }
        
        // Contains
        
        print("\n\nempty:\n")
        
        var str: Any? = nil
        
        if String.isEmpty(str) {
            print("\"\(String(describing: str))\" is empty string")
        } else {
            print("\"\(String(describing: str))\" is NOT empty string")
        }
        
        str = ""
        
        if String.isEmpty(str) {
            print("\"\(String(describing: str))\" is empty string")
        } else {
            print("\"\(String(describing: str))\" is NOT empty string")
        }
        
        str = "      "
        
        if String.isEmpty(str) {
            print("\"\(String(describing: str))\" is empty string")
        } else {
            print("\"\(String(describing: str))\" is NOT empty string")
        }
        
        str = "Hello"
        
        if String.isEmpty(str) {
            print("\"\(String(describing: str))\" is empty string")
        } else {
            print("\"\(String(describing: str))\" is NOT empty string")
        }
        
        // Email
        
        print("\n\nemail:\n")
        
        s = "adrian@byvapps.com"
        
        if s.isEmail() {
            print("\"\(s)\" is an email")
        } else {
            print("\"\(s)\" is NOT an email")
        }
        
        s = "adrian-byvapps.com"
        
        if s.isEmail() {
            print("\"\(s)\" is an email")
        } else {
            print("\"\(s)\" is NOT an email")
        }
        
        // Versions
        
        print("\n\nversions:\n")
        
        var v1 = "10.0"
        var v2 = "10.0.1"
        if v1.isOlderThan(v2) {
            print("\(v1) is Older than \(v2)")
        } else if v1.isNewerThan(v2) {
            print("\(v1) is Newer than \(v2)")
        } else {
            print("\(v1) is Equal to \(v2)")
        }
        
        v1 = "10.0.1"
        v2 = "10.0"
        if v1.isOlderThan(v2) {
            print("\(v1) is Older than \(v2)")
        } else if v1.isNewerThan(v2) {
            print("\(v1) is Newer than \(v2)")
        } else {
            print("\(v1) is Equal to \(v2)")
        }
        
        v1 = "10.0.1"
        v2 = "10.0.1"
        if v1.isOlderThan(v2) {
            print("\(v1) is Older than \(v2)")
        } else if v1.isNewerThan(v2) {
            print("\(v1) is Newer than \(v2)")
        } else {
            print("\(v1) is Equal to \(v2)")
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

