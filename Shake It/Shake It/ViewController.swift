//
//  ViewController.swift
//  Shake It
//
//  Created by Ricardo Canales on 7/28/15.
//  Copyright © 2015 canalesb. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var player: AVAudioPlayer = AVAudioPlayer()
    
    var sounds = ["bell", "dumdum", "exclaim"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if event?.subtype == UIEventSubtype.MotionShake {
            
            let fileLocation = NSBundle.mainBundle().pathForResource(sounds[Int(arc4random_uniform(UInt32(3)))], ofType: "mp3")
            
            do {
                try player = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: fileLocation!))
                player.play()
            } catch {
                // error
            }
            
            
        }
    }


}

