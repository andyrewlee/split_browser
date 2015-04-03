//
//  ViewController.swift
//  vsplit
//
//  Created by Jae Hoon Lee on 4/2/15.
//  Copyright (c) 2015 Jae Hoon Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var firstWebView: UIWebView!
    
    @IBOutlet weak var secondWebView: UIWebView!
    @IBOutlet weak var firstWebViewBrowserLabel: UILabel!
    @IBOutlet weak var secondWebViewBrowserLabel: UILabel!
    
    @IBOutlet weak var firstWebViewInput: UITextField!
    @IBOutlet weak var secondWebViewInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let url = NSURL(string: "http://www.wikipedia.com")
        let requestObj = NSURLRequest(URL: url!)
        firstWebView.loadRequest(requestObj)
        secondWebView.loadRequest(requestObj)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.currentDevice().orientation.isLandscape.boolValue {
            firstWebViewBrowserLabel.text = "L"
            secondWebViewBrowserLabel.text = "R"
        } else {
            firstWebViewBrowserLabel.text = "T"
            secondWebViewBrowserLabel.text = "B"
        }
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        println(textField.text)
        if textField.tag == 1 {
            let url = NSURL(string: textField.text)
            let requestObj = NSURLRequest(URL: url!)
            firstWebView.loadRequest(requestObj)
        } else {
            let url = NSURL(string: textField.text)
            let requestObj = NSURLRequest(URL: url!)
            secondWebView.loadRequest(requestObj)
        }
        return true;
    }
}