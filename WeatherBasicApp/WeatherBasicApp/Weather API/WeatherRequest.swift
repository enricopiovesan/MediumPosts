//
//  WeatherRequest.swift
//  WeatherBasicApp
//
//  Created by Enrico Piovesan on 2018-01-01.
//  Copyright © 2018 Enrico Piovesan. All rights reserved.
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
        let xMashapeHost = "X_Mashape_Host_Value"
        let xMashapeKey = "X_Mashape_Key_Value"
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
