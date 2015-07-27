//
//  ViewController.swift
//  Cat Years
//
//  Created by Ricardo Canales on 7/22/15.
//  Copyright (c) 2015 canalesb. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var yearsTextField: UITextField!
    @IBOutlet weak var answerLabel: UILabel!
    @IBAction func calculateButton(sender: AnyObject) {
        var enteredAge = yearsTextField.text.toInt()
        
        if enteredAge != nil {
            var catYears = enteredAge! * 7
            
            println("Age: " + String(catYears))
            
            answerLabel.text = "Your cat is \(catYears)"
            
        } else {
            answerLabel.text = "Enter the age"
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

