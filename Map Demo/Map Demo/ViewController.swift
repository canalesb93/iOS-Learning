//
//  ViewController.swift
//  Map Demo
//
//  Created by Ricardo Canales on 7/26/15.
//  Copyright © 2015 canalesb. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var trackingButton: UIBarButtonItem!
    
    var locationManager = CLLocationManager()
    var tracking = false
    
    var annotation = MKPointAnnotation()
//    var annotation = MKAnnotationView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()

        
        map.delegate = self
        
        let latitude:CLLocationDegrees = 40.7
        let longitude:CLLocationDegrees = -73.9
        
        // ZOOM Levels
        let latDelta:CLLocationDegrees = 0.01
        let lonDelta:CLLocationDegrees = 0.01
        
        let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        map.setRegion(region, animated: true)
        
        // Add Anotation
        let annotationTemp = MKPointAnnotation()
        annotationTemp.coordinate = location
        annotationTemp.title = "Randy"
        annotationTemp.subtitle = "Some random place."
        
        map.addAnnotation(annotationTemp)
        
        // Global annotation
        annotation.title = "Last known location"
        annotation.subtitle = "Last tracked location recieved by device"
        // Add gesture
        let uilpgr = UILongPressGestureRecognizer(target: self, action: "action:")
        uilpgr.minimumPressDuration = 1.2
        
        map.addGestureRecognizer(uilpgr)
        
    }
    
    // called when annotation is added
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {

        let identifier = "pin"
        
        var view: MKAnnotationView
        if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier) as MKAnnotationView? { // 2
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            // 3
            view = MKAnnotationView(annotation: annotation, reuseIdentifier: "Attraction")
            view.canShowCallout = true
//            view.calloutOffset = CGPoint(x: -5, y: 5)
            let button = UIButton(type: .DetailDisclosure)
            view.image = UIImage(named: "star")
            view.centerOffset = CGPoint(x: 0, y: -32)
//            view.pinTintColor = MKPinAnnotationView.purplePinColor()
            view.rightCalloutAccessoryView = button as UIView

        }
        return view
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        print(locations)
        
        let userLocation:CLLocation = locations[0] as CLLocation
        
        let latitude = userLocation.coordinate.latitude
        let longitude = userLocation.coordinate.longitude
        
        // ZOOM Levels
        let latDelta:CLLocationDegrees = 0.01
        let lonDelta:CLLocationDegrees = 0.01
        
        let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)

        map.removeAnnotation(annotation)
        annotation.coordinate = location
        map.addAnnotation(annotation)
        
        map.setRegion(region, animated: true)
        
    }

    
    func action(gestureRecognizer: UIGestureRecognizer){
        print("Gesture Recognized")
        
        if gestureRecognizer.state == UIGestureRecognizerState.Began {
            let touchPoint = gestureRecognizer.locationInView(self.map)
            
            let newCoordinate:CLLocationCoordinate2D = map.convertPoint(touchPoint, toCoordinateFromView: self.map)
            
            // Add Anotation using custom annotation class
//            let annotation = AttractionAnnotation(coordinate: newCoordinate, title: "New annotation", subtitle: "This mah subtitle!")
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = newCoordinate
            annotation.title = "Randy"
            annotation.subtitle = "Some random place."
            
            
            map.addAnnotation(annotation)
        }
        
    }
    
    
    @IBAction func trackLocation(sender: AnyObject) {
        if tracking {
            locationManager.stopUpdatingLocation()
            trackingButton.title = "Start Tracking"
        } else {
            locationManager.startUpdatingLocation()
            trackingButton.title = "Stop Tracking"
        }
        tracking = !tracking
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

