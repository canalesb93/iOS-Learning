//
//  AttractionAnnotationView.swift
//  Map Demo
//
//  Created by Ricardo Canales on 7/27/15.
//  Copyright © 2015 canalesb. All rights reserved.
//

import UIKit
import MapKit

class AttractionAnnotationView: MKAnnotationView {
    // Required for MKAnnotationView
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // Called when drawing the AttractionAnnotationView
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
//        image = UIImage(named: "star")
//        self.centerOffset(
    }
}