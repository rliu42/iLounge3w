//
//  ViewController.swift
//  iLounge
//
//  Created by runpeng liu on 7/2/15.
//  Copyright (c) 2015 Runpeng Liu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var imageView: UIImageView!
    
    let screenSize: CGRect = UIScreen.mainScreen().bounds

    var requestObj = NSURLRequest(URL: NSURL(string: "http://72.29.29.198:3000")!);
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setImagePortrait()
        //UIView.setAnimationsEnabled(false)
        self.webView.delegate = self
        self.webView.loadRequest(requestObj)
        self.webView.scrollView.bounces = false
    }
    
    /*
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }*/

    func setImagePortrait() {
        var screenWidth = screenSize.width
        var screenHeight = screenSize.height
        
        if (screenHeight == 667) {
            // iPhone 6
            imageView.image = UIImage(named: ("Default-667h@2x") )
        } else if (screenHeight == 568) {
            // iPhone 5
            imageView.image = UIImage(named: ("Default-568h@2x") )
        } else if (screenHeight < 568) {
            // iPhone 4
            imageView.image = UIImage(named: ("Default@2x") )
        } else if (screenHeight > 667) {
            // iPad
            imageView.image = UIImage(named: ("Default-Portrait@2x") )
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    
    func webViewDidFinishLoad(webView: UIWebView) {
        UIView.animateWithDuration(1.5, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            self.webView.alpha = 1.0
        }, completion: nil)
        UIView.animateWithDuration(1.0, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.imageView.alpha = 0
        }, completion: nil)
    }

}
