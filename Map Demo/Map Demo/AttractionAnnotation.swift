//
//  AttractionAnnotation.swift
//  Map Demo
//
//  Created by Ricardo Canales on 7/27/15.
//  Copyright © 2015 canalesb. All rights reserved.
//

import UIKit
import MapKit

class AttractionAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
}