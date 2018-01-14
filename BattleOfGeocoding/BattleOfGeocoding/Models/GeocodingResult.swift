//
//  GeocodingResult.swift
//  ReverseGeocoding
//
//  Created by Enrico Piovesan on 2018-01-13.
//  Copyright © 2018 Enrico Piovesan. All rights reserved.
//

import CoreLocation

class GeocodingResult {
    var native: Geocoding?
    var googleMaps: Geocoding?
    var address: String
    
    init(_ address: String) {
        self.address = address
    }
    
    func getDistance() -> Int? {
        if native != nil || googleMaps != nil {
            let coordinate1 = CLLocation(latitude: native!.coordinates.latitude, longitude: native!.coordinates.longitude)
            let coordinate2 = CLLocation(latitude: googleMaps!.coordinates.latitude, longitude: googleMaps!.coordinates.longitude)
            return Int(coordinate1.distance(from: coordinate2))
        } else {
            return nil
        }
    }
    
}

