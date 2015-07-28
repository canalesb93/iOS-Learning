//
//  ViewController.swift
//  Swipes & Shakes
//
//  Created by Ricardo Canales on 7/28/15.
//  Copyright © 2015 canalesb. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let swipeRight = UISwipeGestureRecognizer(target: self, action: "swiped:")
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: "swiped:")
        swipeUp.direction = UISwipeGestureRecognizerDirection.Up
        self.view.addGestureRecognizer(swipeUp)
        
        
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if event?.subtype == UIEventSubtype.MotionShake {
            print("Device was shaken")
        }
    }
    
    func swiped(gesture: UIGestureRecognizer){
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction  {
            case UISwipeGestureRecognizerDirection.Right:
                print("Swiped Right")
            case UISwipeGestureRecognizerDirection.Up:
                print("Swiped Up")
            default:
                break
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

