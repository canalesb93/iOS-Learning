//
//  ViewController.swift
//  Memorable Places
//
//  Created by Ricardo Canales on 7/27/15.
//  Copyright © 2015 canalesb. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    var manager: CLLocationManager!
    
    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        
        if activePlace == -1 {
            manager.requestWhenInUseAuthorization()
            manager.startUpdatingLocation()
        } else {
            let latitude = NSString(string: places[activePlace]["lat"]!).doubleValue
            let longitude = NSString(string: places[activePlace]["lon"]!).doubleValue
            let coordinate = CLLocationCoordinate2DMake(latitude, longitude)
            
            let latDelta:CLLocationDegrees = 0.01
            let lonDelta:CLLocationDegrees = 0.01
            let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
            
            let region:MKCoordinateRegion = MKCoordinateRegionMake(coordinate, span)
            
            self.map.setRegion(region, animated: true)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            print(places)
            annotation.title = places[activePlace]["name"]
            
            self.map.addAnnotation(annotation)
        }
        
        let uilpgr = UILongPressGestureRecognizer(target: self, action: "action:")
        uilpgr.minimumPressDuration = 1.0
        
        map.addGestureRecognizer(uilpgr)
        
    }
    
    func action(gestureRecognizer:UIGestureRecognizer) {
        
        if gestureRecognizer.state == UIGestureRecognizerState.Began {
            let touchPoint = gestureRecognizer.locationInView(self.map)
            
            let newCoordinate = self.map.convertPoint(touchPoint, toCoordinateFromView: self.map)
            
            
            // reverse geocoder
            CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: newCoordinate.latitude, longitude: newCoordinate.longitude), completionHandler: { (placemarks, error) -> Void in
                
                var title = ""
                
                if error == nil {
                    if let p = placemarks as [CLPlacemark]! {
                        let loc:CLPlacemark = p[0]
                        var subThoroughfare = ""
                        var thoroughfare = ""
                        if loc.subThoroughfare != nil {
                            subThoroughfare = loc.subThoroughfare!
                        }
                        
                        if loc.thoroughfare != nil {
                            thoroughfare = loc.thoroughfare!
                        }
                        
                        title = "\(subThoroughfare) \(thoroughfare)"
                    }
                }
                
                if title == "" {
                    title = "Added \(NSDate())"
                }
                
                places.append(["name":title, "lat":"\(newCoordinate.latitude)", "lon":"\(newCoordinate.longitude)"])

                let annotation = MKPointAnnotation()
                annotation.coordinate = newCoordinate
                annotation.title = title
                
                self.map.addAnnotation(annotation)
                
            })
            
            

        }
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0]
        
        let latitude = userLocation.coordinate.latitude
        let longitude = userLocation.coordinate.longitude
        let coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        
        let latDelta:CLLocationDegrees = 0.01
        let lonDelta:CLLocationDegrees = 0.01
        let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)

        let region:MKCoordinateRegion = MKCoordinateRegionMake(coordinate, span)
        
        self.map.setRegion(region, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

}

