//
//  SecondViewController.swift
//  To Do List
//
//  Created by Ricardo Canales on 7/25/15.
//  Copyright © 2015 canalesb. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var itemTF: UITextField!
    
    @IBAction func addItemButton(sender: AnyObject) {
        addItem()
    }
    
    func addItem(){
        toDoList.append(itemTF.text!)
        itemTF.text = ""
        NSUserDefaults.standardUserDefaults().setObject(toDoList, forKey: "toDoList")

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        itemTF.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        addItem()
        itemTF.resignFirstResponder()
        return true
    }

}

