//
//  ViewController.swift
//  Audio Back to Bach
//
//  Created by Ricardo Canales on 7/28/15.
//  Copyright © 2015 canalesb. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player: AVAudioPlayer = AVAudioPlayer()

    @IBAction func play(sender: AnyObject) {
        player.play()
    }
    
    @IBOutlet weak var volumeSlider: UISlider!
    @IBAction func adjustVolume(sender: AnyObject) {
        player.volume = volumeSlider.value
    }


    @IBOutlet weak var scrubSlider: UISlider!
    @IBAction func scrub(sender: AnyObject) {
        
        player.currentTime = NSTimeInterval(scrubSlider.value)
        
    }
    
    @IBAction func pause(sender: AnyObject) {
        player.pause()
    }
    @IBAction func stop(sender: AnyObject) {
        player.pause()
        do {
            try player = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("bach", ofType: "mp3")!))
            
        } catch {
            // didn't work!
        }
    }
    
    func updateScrubSlider(){
        scrubSlider.value = Float(player.currentTime)
        print(player.currentTime)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
        
        try player = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("bach", ofType: "mp3")!))
            scrubSlider.maximumValue = Float(player.duration)
        
        } catch {
            // didn't work!
        }
        
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("updateScrubSlider"), userInfo: nil, repeats: true)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

