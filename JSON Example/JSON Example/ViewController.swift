//
//  ViewController.swift
//  JSON Example
//
//  Created by Ricardo Canales on 7/31/15.
//  Copyright © 2015 canalesb. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var myCity: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = NSURL(string: "http://www.telize.com/geoip")!
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
            if let urlContent = data {
                do {
                    let jsonResult = try NSJSONSerialization.JSONObjectWithData(urlContent, options: NSJSONReadingOptions.MutableContainers)
                    print(jsonResult["city"])
                    
                    // unwrapping
                    if let city = jsonResult["city"] as? String {
                        print(city)
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            self.myCity.text = city
                        })
                    }
                } catch {
                    print("Serialization Failed")
                }
            }
        }
        task.resume()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

