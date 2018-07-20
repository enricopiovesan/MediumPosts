//
//  GeocodingManager.swift
//  weatherBot
//
//  Created by Enrico Piovesan on 2017-09-04.
//  Copyright © 2017 Enrico Piovesan. All rights reserved.
//

import UIKit
import Alamofire
import MapKit

class GeocodingManager {
    
    var geocoding: Geocoding? = nil
    var geocodingDictionary: NSDictionary
    
    required init(geocodingDictionary: NSDictionary) {
        self.geocodingDictionary = geocodingDictionary
    }
    
    // MARK:- Geocoding serialize
    func serialize() -> Geocoding? {
    
        if let resultArray = self.geocodingDictionary["results"] as? NSArray {
            if let resultDictionary = resultArray[0] as? [String:AnyObject] {
                
                //coordinates
                var coordinates = CLLocationCoordinate2D()
                if let value = resultDictionary["geometry"] as? NSDictionary {
                    if let location = value["location"] as? [String:AnyObject] {
                        let latitude = CLLocationDegrees(location["lat"]?.floatValue ?? 0.0)
                        let longitude = CLLocationDegrees(location["lng"]?.floatValue ?? 0.0)
                        coordinates.latitude = latitude
                        coordinates.longitude = CLLocationDegrees(longitude)
                    }
                }
                
                if coordinates.latitude != 0.0 {
                    
                    let geocoding = Geocoding(coordinates: coordinates)
                    
                    //name
                    if let value = resultDictionary["address_components"] as? NSArray{
                        if let component = value[0] as? [String:Any] {
                            geocoding.name = component["long_name"] as? String
                        }
                    }
                    
                    //formattedAddress
                    if let value = resultDictionary["formatted_address"] as? String {
                        geocoding.formattedAddress = value
                    }
                    
                    //bounds
                    if let geometry = resultDictionary["geometry"] as? [String:Any] {
                        
                        if let bounds = geometry["bounds"] as? [String:AnyObject] {
                            if let value = bounds["northeast"] as? [String:AnyObject] {
                                geocoding.boundNorthEast = CLLocationCoordinate2D(latitude: CLLocationDegrees(value["lat"]!.floatValue), longitude: CLLocationDegrees(value["lng"]!.floatValue))
                            }
                            
                            if let value = bounds["southwest"] as? [String:AnyObject] {
                                geocoding.boundSouthWest = CLLocationCoordinate2D(latitude: CLLocationDegrees(value["lat"]!.floatValue), longitude: CLLocationDegrees(value["lng"]!.floatValue))
                            }
                        }
                        
                    }
                    
                    return geocoding
                    
                } else {
                    return nil
                }
                
            }
            
        }
        
        return nil

    }
    
}
