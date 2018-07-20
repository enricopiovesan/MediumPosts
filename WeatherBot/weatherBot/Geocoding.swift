//
//  Geocoding.swift
//  weatherBot
//
//  Created by Enrico Piovesan on 2017-09-04.
//  Copyright © 2017 Enrico Piovesan. All rights reserved.
//

import MapKit
import UIKit

class Geocoding {
    
    var coordinates: CLLocationCoordinate2D
    var name: String?
    var formattedAddress: String?
    var boundNorthEast: CLLocationCoordinate2D?
    var boundSouthWest: CLLocationCoordinate2D?
    
    init(coordinates: CLLocationCoordinate2D) {
        self.coordinates = coordinates
    }
    
}
