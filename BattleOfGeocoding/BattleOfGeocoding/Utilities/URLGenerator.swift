//
//  URLGenerator.swift
//  ReverseGeocoding
//
//  Created by Enrico Piovesan on 2018-01-13.
//  Copyright © 2018 Enrico Piovesan. All rights reserved.
//

import UIKit

class URLGenerator {
    
    static let geocodingbaseUrl: String = "https://maps.googleapis.com/maps/api/geocode"

    class func geocodingApiUrlForPathString(path: String) -> String {
        
        return URLGenerator.geocodingbaseUrl + "/" + path
        
    }
    
}

