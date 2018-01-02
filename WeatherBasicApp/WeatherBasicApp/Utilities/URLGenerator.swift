//
//  URLGenerator.swift
//  WeatherBasicApp
//
//  Created by Enrico Piovesan on 2018-01-01.
//  Copyright © 2018 Enrico Piovesan. All rights reserved.
//

import UIKit

class URLGenerator {
    
    static let weatherbaseUrl: String = "https://simple-weather.p.mashape.com"
    
    class func weatherApiUrlForPathString(path: String) -> String {
        
        return URLGenerator.weatherbaseUrl + "/" + path
        
    }
    
}

