//
//  WeatherRequest.swift
//  weatherBot
//
//  Created by Enrico Piovesan on 2017-09-04.
//  Copyright © 2017 Enrico Piovesan. All rights reserved.
//

import UIKit
import Alamofire
import MapKit

class WeatherRequest {
    
    var coordinates: CLLocationCoordinate2D
    
    init(coordinates: CLLocationCoordinate2D) {
        self.coordinates = coordinates
    }
    
    func getHeaders() -> HTTPHeaders {
        let xMashapeHost = "simple-weather.p.mashape.com"
        let xMashapeKey = "YOUR_KEY_HERE" 
        let headers: HTTPHeaders = [
            "X-Mashape-Host": xMashapeHost,
            "X-Mashape-Key": xMashapeKey,
            ]
        return headers
    }
    
    func toParameters() -> Parameters {
        
        let parameters: Parameters = [
            "lat": self.coordinates.latitude.description,
            "lng": self.coordinates.longitude.description,
        ]
        
        return parameters
    }
    
}
