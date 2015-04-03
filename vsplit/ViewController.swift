//
//  ViewController.swift
//  vsplit
//
//  Created by Jae Hoon Lee on 4/2/15.
//  Copyright (c) 2015 Jae Hoon Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIWebViewDelegate {

    @IBOutlet weak var firstWebView: UIWebView!
    @IBOutlet weak var secondWebView: UIWebView!
    
    @IBOutlet weak var firstWebViewBrowserLabel: UILabel!
    @IBOutlet weak var secondWebViewBrowserLabel: UILabel!
    
    @IBOutlet weak var firstWebViewInput: UITextField!
    @IBOutlet weak var secondWebViewInput: UITextField!
    
    var firstRefreshControl:UIRefreshControl!
    var secondRefreshControl:UIRefreshControl!
    
    // Default urls for first time using app
    var urlOne = "dailybeast.com"
    var urlTwo = "reddit.com/.compact"
    
    var brandColorOne = UIColor(red: 0.863, green: 0.420, blue:0.141, alpha: 1.00) // Orange
    var brandColorTwo = UIColor(red: 0.020, green: 0.149, blue:0.318, alpha: 1.00) // Navy Blue
    
    func webViewDidFinishLoad(webView: UIWebView) {
        webView.opaque = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareBrowsers()
        firstRefreshControl = UIRefreshControl()
        secondRefreshControl = UIRefreshControl()
        firstRefreshControl.tag = 1
        secondRefreshControl.tag = 2
        
        firstRefreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        secondRefreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        firstWebView.scrollView.addSubview(firstRefreshControl)
        secondWebView.scrollView.addSubview(secondRefreshControl)
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
   
    /* Text Field Protocol */
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        if textField.text != "" {
            if textField.tag == 1 {
                let url = NSURL(string: textField.text)
                let requestObj = NSURLRequest(URL: url!)
                firstWebView.loadRequest(requestObj)
            } else {
                let url = NSURL(string: textField.text)
                let requestObj = NSURLRequest(URL: url!)
                secondWebView.loadRequest(requestObj)
            }
        }
        return true;
    }
    
    func prepareFirstBrowser(first: Bool, AndSecond: Bool) {
        if first == true {
            if  urlOne.hasPrefix("http://") == false {
                urlOne = "http://" + urlOne
                println(urlOne)
            }
            let requestObjOne = NSURLRequest(URL: NSURL(string: urlOne)!)
            firstWebView.backgroundColor = brandColorOne
            firstWebViewBrowserLabel.textColor = brandColorOne
            firstWebView.opaque = false
            firstWebView.loadRequest(requestObjOne)
            firstWebViewInput.text = urlOne
        }
        
        if AndSecond == true {
            if  urlTwo.hasPrefix("http://") == false {
                urlTwo = "http://" + urlTwo
                println(urlOne)
            }
            let requestObjTwo = NSURLRequest(URL: NSURL(string: urlTwo)!)
            secondWebView.backgroundColor = brandColorTwo
            secondWebViewBrowserLabel.textColor = brandColorTwo
            secondWebView.opaque = false
            secondWebView.loadRequest(requestObjTwo)
            secondWebViewInput.text = urlTwo
        }
    }
    
    func prepareBrowsers() {
        prepareFirstBrowser(true, AndSecond: true)
    }
    
    func refresh(sender:UIRefreshControl) {
        sender.endRefreshing()
        if sender.tag == 1 {
            prepareFirstBrowser(true, AndSecond: false)
        } else {
            prepareFirstBrowser(false, AndSecond: true)
        }
    }
}