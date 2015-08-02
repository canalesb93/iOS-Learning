//
//  ViewController.swift
//  Constraints
//
//  Created by Ricardo Canales on 8/1/15.
//  Copyright © 2015 canalesb. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func buttonTapped(sender: UIButton) {
        if sender.titleForState(.Normal) == "X" {
            sender.setTitle("A very long title for this button", forState: .Normal)
        } else {
            sender.setTitle("X", forState: .Normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


}

