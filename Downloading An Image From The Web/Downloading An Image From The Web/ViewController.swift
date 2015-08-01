//
//  ViewController.swift
//  Downloading An Image From The Web
//
//  Created by Ricardo Canales on 7/30/15.
//  Copyright © 2015 canalesb. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let url = NSURL(string: "https://i.imgur.com/v1rxkR1.jpg")
        
        let urlRequest = NSURLRequest(URL: url!)
        
        // ios 9 deprecated
//        NSURLConnection.sendAsynchronousRequest(urlRequest, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in
//            if error != nil {
//                print(error)
//            } else {
//                if let background = UIImage(data: data!) {
//                    self.image.image = background
//                }
//            }
//        }
        
        // ios 9 new way
        let task = NSURLSession.sharedSession().dataTaskWithRequest(urlRequest, completionHandler: { (data, response, error) -> Void in
            if error != nil {
                print(error)
            } else {
                if let background = UIImage(data: data!){
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.image.image = background
                        let documentsDirectory:String?
                        
                        let paths:[AnyObject] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
                        
                        if paths.count > 0 {

                            documentsDirectory = paths[0] as? String
                            let savePath = documentsDirectory! + "/space.jpg"
                            NSFileManager.defaultManager().createFileAtPath(savePath, contents: data, attributes: nil)
                            self.image.image = UIImage(named: savePath)
                        }
                    })
                
                }
            }
        })
        
        task.resume()
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

