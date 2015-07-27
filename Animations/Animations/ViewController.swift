//
//  ViewController.swift
//  Animations
//
//  Created by Ricardo Canales on 7/26/15.
//  Copyright © 2015 canalesb. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var counter = 1
    var timer = NSTimer()
    var width = CGFloat()
    var height = CGFloat()
    
    var state = false
    
    @IBOutlet weak var alienImage: UIImageView!
    
    @IBAction func updateImage(sender: AnyObject) {
        state = !state
        if state {
            timer.invalidate()
        } else {
            timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("doAnimation"), userInfo: nil, repeats: true)
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("doAnimation"), userInfo: nil, repeats: true)
        
    }
    
    func doAnimation(){
        alienImage.image = UIImage(named: "frame" + String((counter%5)+1) + ".png")
        counter++
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidLayoutSubviews() {
//        alienImage.center = CGPointMake(alienImage.center.x - 400, alienImage.center.y)
        width = alienImage.frame.size.width
        height = alienImage.frame.size.height
        alienImage.alpha = 0
        
        alienImage.frame = CGRectMake(alienImage.center.x - 400, alienImage.center.y, 0, 0)
    }
    
    override func viewDidAppear(animated: Bool) {
        
        UIView.animateWithDuration(1) { () -> Void in
//            self.alienImage.center = CGPointMake(self.alienImage.center.x + 400, self.alienImage.center.y - 50)
            self.alienImage.alpha = 1
            self.alienImage.frame = CGRectMake(self.alienImage.center.x + 400 - self.width / 2, self.alienImage.center.y - self.height / 2, self.width, self.height)
        }
        
    }

}

