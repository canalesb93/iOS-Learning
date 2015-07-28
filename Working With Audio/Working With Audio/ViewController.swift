//
//  ViewController.swift
//  Working With Audio
//
//  Created by Ricardo Canales on 7/28/15.
//  Copyright © 2015 canalesb. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player: AVAudioPlayer = AVAudioPlayer()

    @IBAction func play(sender: AnyObject) {
        let audioPath = NSBundle.mainBundle().pathForResource("bach", ofType: "mp3")!
        
        do {
            try player = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: audioPath))
            player.play()
        } catch {
            // Process error here
        }
    }
    @IBAction func pause(sender: AnyObject) {
        player.pause()
    }
    @IBOutlet weak var slider: UISlider!
    @IBAction func adjustVolume(sender: AnyObject) {
        player.volume = slider.value 
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

