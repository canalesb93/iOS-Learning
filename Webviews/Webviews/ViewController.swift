//
//  ViewController.swift
//  Webviews
//
//  Created by Ricardo Canales on 7/31/15.
//  Copyright © 2015 canalesb. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var webview: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        /* let url = NSURL(string: "https://www.google.com")
        
        let request = NSURLRequest(URL: url!)
        
        webview.loadRequest(request)

        */
        
        let html = "<html><body><h1>My Page</h1><p>This is my webpage</p></body></html>"
        
        webview.loadHTMLString(html, baseURL: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

