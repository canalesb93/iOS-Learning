//
//  ViewController.swift
//  Advanced Segues
//
//  Created by Ricardo Canales on 7/27/15.
//  Copyright © 2015 canalesb. All rights reserved.
//

import UIKit

var rowCounter = -1

class ViewController: UIViewController {

    @IBOutlet weak var messageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        messageLabel.text = "Came from row \(rowCounter)"
        print(rowCounter)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

