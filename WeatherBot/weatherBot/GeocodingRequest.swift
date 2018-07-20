//
//  GeocodingRequest.swift
//  weatherBot
//
//  Created by Enrico Piovesan on 2017-09-04.
//  Copyright © 2017 Enrico Piovesan. All rights reserved.
//

import UIKit
import Alamofire
import MapKit

class GeocodingRequest {
    
    var address: String
    
    init(address: String) {
        self.address = address
    }
    
    func toParameters() -> Parameters {
        
        let parameters: Parameters = [
            "address": self.address,
            "key": "YOUR_KEY_HERE"
            ]
        
        return parameters
    }
    
}
