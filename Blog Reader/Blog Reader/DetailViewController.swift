//
//  DetailViewController.swift
//  Blog Reader
//
//  Created by Ricardo Canales on 7/31/15.
//  Copyright © 2015 canalesb. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var webview: UIWebView!



    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let label = self.detailDescriptionLabel {
            label.text = "Item Tapped"
        }
        webview.loadHTMLString(activeItem, baseURL: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

