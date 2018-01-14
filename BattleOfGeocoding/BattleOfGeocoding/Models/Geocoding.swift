//
//  Geocoding.swift
//  ReverseGeocoding
//
//  Created by Enrico Piovesan on 2018-01-13.
//  Copyright © 2018 Enrico Piovesan. All rights reserved.
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
