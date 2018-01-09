//
//  WeatherIntent.swift
//  AiBasicApp
//
//  Created by Enrico Piovesan on 2018-01-06.
//  Copyright © 2018 Enrico Piovesan. All rights reserved.
//

import UIKit

class WeatherIntent {
    
    var condition : String?
    var outfit : String?
    
    init(_ parameters: NSDictionary) {
        serialize(parameters)
    }
    
    // MARK : serialize object
    func serialize(_ parameters: NSDictionary) {
        if let condition = parameters["condition"] as? String {
            self.condition = condition
        }
        if let outfit = parameters["outfit"] as? String {
            self.outfit = outfit
        }
    }
    
}
