//
//  ViewController.swift
//  Whats The Weather
//
//  Created by Ricardo Canales on 7/25/15.
//  Copyright © 2015 canalesb. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cityTextField: UITextField!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBAction func findWeather(sender: AnyObject) {
        
        var success = false
        
        let attempted_url = NSURL(string: "http://www.weather-forecast.com/locations/" + cityTextField.text!.stringByReplacingOccurrencesOfString(" ", withString: "-") + "/forecasts/latest")
        
        if let url = attempted_url {
            
            let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
                if let urlContent = data {
                    let webContent = NSString(data: urlContent, encoding: NSUTF8StringEncoding)
                    
                    let websiteArray = webContent?.componentsSeparatedByString("3 Day Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">")
                    
                    if websiteArray!.count > 1 {
                        
                        let weatherArray = websiteArray![1].componentsSeparatedByString("</span>")
                        if weatherArray.count > 1 {
                            
                            success = true
                            
                            let weatherSummary = weatherArray[0].stringByReplacingOccurrencesOfString("&deg;", withString: "º")
                            
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                self.resultLabel.text = weatherSummary
                            })
                            
                        }
                        
                    }
                    
                }
                
                if success == false {
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.resultLabel.text = "Unsuccess - Couldn't find weather for that city - please try again."
                    })
                    
                }
                
            }
            
            task.resume()
            
        } else {
            
            resultLabel.text = "Incorrect URL - Couldn't find weather for that city - please try again."
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }

}

