//
//  ViewController.swift
//  iLounge
//
//  Created by runpeng liu on 7/2/15.
//  Copyright (c) 2015 Runpeng Liu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIView.setAnimationsEnabled(false)
        let resultsURL = NSURL (string: "http://runpengliu.com:3000");
        let requestObj = NSURLRequest(URL: resultsURL!);
        self.webView.loadRequest(requestObj);
        self.webView.scrollView.bounces = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }

}
