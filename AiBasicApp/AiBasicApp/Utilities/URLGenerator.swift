//
//  URLGenerator.swift
//  AiBasicApp
//
//  Created by Enrico Piovesan on 2018-01-04.
//  Copyright © 2018 Enrico Piovesan. All rights reserved.
//

import UIKit

class URLGenerator {
    
    static let AIbaseUrl: String = "https://api.api.ai"
    static let AIversion: String = "v1"
    
    static let weatherbaseUrl: String = "https://simple-weather.p.mashape.com"
    
    static let geocodingbaseUrl: String = "https://maps.googleapis.com/maps/api/geocode"
    
    class func apiUrlForPath(path: String) -> NSURL {
        
        let urlString = URLGenerator.AIbaseUrl + "/" + URLGenerator.AIversion + "/" + path
        return NSURL(string: urlString)!
        
    }
    
    class func aiApiUrlForPathString(path: String) -> String {
        
        return URLGenerator.AIbaseUrl + "/" + URLGenerator.AIversion + "/" + path
        
    }
    
    class func weatherApiUrlForPathString(path: String) -> String {
        
        return URLGenerator.weatherbaseUrl + "/" + path
        
    }
    
    class func geocodingApiUrlForPathString(path: String) -> String {
        
        return URLGenerator.geocodingbaseUrl + "/" + path
        
    }
    
}
