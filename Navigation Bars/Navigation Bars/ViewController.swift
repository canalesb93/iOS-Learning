//
//  ViewController.swift
//  Navigation Bars
//
//  Created by Ricardo Canales on 7/23/15.
//  Copyright (c) 2015 canalesb. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var count = 0;
    var timer = NSTimer()
    var status = false
    
    func updateTime(){
        count++
        time.text = String(count)
        
    }
    
    @IBOutlet weak var playButton: UIBarButtonItem!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var time: UILabel!
    
    @IBAction func stop(sender: AnyObject) {
        timer.invalidate()
        count = 0
        time.text = "0"
    }
    
    func toggleActions(){
        status = !status
        var newButton: UIBarButtonItem
        if status {
            newButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Pause, target: self, action: "toggleActions")
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("updateTime"), userInfo: nil, repeats: true)
        } else {
            newButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Play, target: self, action: Selector("toggleActions"))
            timer.invalidate()
        }
        toolBar.items![2] = newButton

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playButton.action = "toggleActions"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

